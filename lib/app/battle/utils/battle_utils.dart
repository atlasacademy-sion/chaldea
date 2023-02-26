import 'dart:math';
import 'dart:typed_data';

import 'package:chaldea/models/db.dart';
import 'package:chaldea/models/gamedata/gamedata.dart';

/// Referencing:
/// https://apps.atlasacademy.io/fgo-docs/deeper/battle/damage.html
/// DamageMod caps are applied when gathering the parameters.
int calculateDamage(final DamageParameters param) {
  final constData = db.gameData.constData;

  if (!constData.classInfo.containsKey(param.attackerClass.id)) {
    throw 'Invalid class: ${param.attackerClass}';
  }

  final classAttackCorrection = toModifier(constData.classInfo[param.attackerClass.id]!.attackRate);
  final classAdvantage = toModifier(param.classAdvantage); // class relation is provisioned due to overwriteClassRelation

  if (!constData.attributeRelation.containsKey(param.attackerAttribute) ||
      !constData.attributeRelation[param.attackerAttribute]!.containsKey(param.defenderAttribute)) {
    throw 'Invalid attributes: attacker: ${param.attackerAttribute}, defender: ${param.defenderAttribute}';
  }
  final attributeAdvantage = toModifier(constData.attributeRelation[param.attackerAttribute]![param.defenderAttribute]!);

  if (!constData.cardInfo.containsKey(param.currentCardType)) {
    throw 'Invalid current card type: ${param.currentCardType}';
  }

  final chainPos = param.isNp ? 1 : param.chainPos;
  final cardCorrection = toModifier(constData.cardInfo[param.currentCardType]![chainPos]!.adjustAtk);

  if (!constData.cardInfo.containsKey(param.firstCardType)) {
    throw 'Invalid first card type: ${param.firstCardType}';
  }
  final firstCardBonus = param.isNp
      ? 0
      : param.isMightyChain
          ? toModifier(constData.cardInfo[CardType.buster]![1]!.addAtk)
          : toModifier(constData.cardInfo[param.firstCardType]![1]!.addAtk);

  final criticalModifier = param.isCritical ? toModifier(constData.constants.criticalAttackRate) : 1;

  final extraRate = param.currentCardType == CardType.extra
      ? param.isTypeChain && param.firstCardType == CardType.buster
          ? constData.constants.extraAttackRateGrand
          : constData.constants.extraAttackRateSingle
      : 1000;
  final extraModifier = toModifier(extraRate);

  final busterChainMod = !param.isNp && param.currentCardType == CardType.buster && param.isTypeChain
      ? toModifier(constData.constants.chainbonusBusterRate) * param.attack
      : 0;

  final damageRate = toModifier(param.damageRate);
  final npSpecificAttackRate = toModifier(param.npSpecificAttackRate);
  final cardBuff = toModifier(param.cardBuff);
  final cardResist = toModifier(param.cardResist);
  final attackBuff = toModifier(param.attackBuff);
  final defenseBuff = toModifier(param.defenseBuff);
  final specificAttackBuff = toModifier(param.specificAttackBuff);
  final specificDefenseBuff = toModifier(param.specificDefenseBuff);
  final criticalDamageBuff = param.isCritical ? toModifier(param.criticalDamageBuff) : 0;
  final npDamageBuff = param.isNp ? toModifier(param.npDamageBuff) : 0;
  final percentAttackBuff = toModifier(param.percentAttackBuff);
  final percentDefenseBuff = toModifier(param.percentDefenseBuff);

  final int totalDamage = (param.attack *
              damageRate *
              (firstCardBonus + cardCorrection * max(1 + cardBuff - cardResist, 0)) *
              classAttackCorrection *
              classAdvantage *
              attributeAdvantage *
              param.fixedRandom *
              toModifier(constData.constants.attackRate) *
              max(1 + attackBuff - defenseBuff, 0) *
              criticalModifier *
              extraModifier *
              max(1 - percentDefenseBuff, 0) *
              max(1 + specificAttackBuff - specificDefenseBuff + criticalDamageBuff + npDamageBuff, 0.001) *
              max(1 + percentAttackBuff, 0.001) *
              npSpecificAttackRate *
              (param.totalHits / 100.0) +
          param.damageAdditionBuff -
          param.damageReductionBuff +
          busterChainMod)
      .toInt();

  return max(0, totalDamage);
}

/// Referencing:
/// https://atlasacademy.github.io/fgo-docs/deeper/battle/np.html
/// Float arithmetic used due to:
/// https://atlasacademy.github.io/fgo-docs/deeper/battle/32-bit-float.html
int calculateAttackNpGain(final AttackNpGainParameters param) {
  final constData = db.gameData.constData;
  if (!constData.cardInfo.containsKey(param.currentCardType)) {
    throw 'Invalid current card type: ${param.currentCardType}';
  }

  final chainPos = param.isNp ? 1 : param.chainPos;
  final cardCorrection = toModifier(constData.cardInfo[param.currentCardType]![chainPos]!.adjustTdGauge);

  if (!constData.cardInfo.containsKey(param.firstCardType)) {
    throw 'Invalid first card type: ${param.firstCardType}';
  }
  final firstCardBonus = param.isNp
      ? 0
      : param.isMightyChain
          ? toModifier(constData.cardInfo[CardType.arts]![1]!.addTdGauge)
          : toModifier(constData.cardInfo[param.firstCardType]![1]!.addTdGauge);
  final criticalModifier = param.isCritical ? toModifier(constData.constants.criticalTdPointRate) : 1.0;

  final cardBuff = toModifier(param.cardBuff);
  final cardResist = toModifier(param.cardResist);
  final npGainBuff = toModifier(param.npGainBuff);

  ByteData float = ByteData(4);
  float.setFloat32(0, cardBuff - cardResist);
  float.setFloat32(0, max(1 + float.getFloat32(0), 0));
  float.setFloat32(0, cardCorrection * float.getFloat32(0));
  float.setFloat32(0, firstCardBonus + float.getFloat32(0));
  final cardGain = float.getFloat32(0);

  float.setFloat32(0, 1 + npGainBuff);
  final npBonusGain = float.getFloat32(0);

  final defenderNpRate = toModifier(param.defenderNpRate);

  float.setFloat32(0, param.attackerNpCharge * criticalModifier);
  float.setFloat32(0, defenderNpRate * float.getFloat32(0));
  float.setFloat32(0, cardGain * float.getFloat32(0));
  float.setFloat32(0, npBonusGain * float.getFloat32(0));
  final beforeOverkill = float.getFloat32(0).floor();

  final overkillModifier = param.isOverkill ? toModifier(constData.constants.overKillNpRate) : 1.0;
  float.setFloat32(0, beforeOverkill * overkillModifier);
  return float.getFloat32(0).floor();
}

/// Referencing:
/// https://atlasacademy.github.io/fgo-docs/deeper/battle/np.html
/// Float arithmetic used due to:
/// https://atlasacademy.github.io/fgo-docs/deeper/battle/32-bit-float.html
int calculateDefendNpGain(final DefendNpGainParameters param) {
  final attackerNpRate = toModifier(param.attackerNpRate);
  final npGainBuff = toModifier(param.npGainBuff);
  final defenseNpGainBuff = toModifier(param.defenseNpGainBuff);

  ByteData float = ByteData(4);
  float.setFloat32(0, 1 + npGainBuff);
  final npBonusGain = float.getFloat32(0);

  float.setFloat32(0, 1 + defenseNpGainBuff);
  final defNpBonusGain = float.getFloat32(0);

  float.setFloat32(0, param.defenderNpCharge * attackerNpRate);
  float.setFloat32(0, npBonusGain * float.getFloat32(0));
  float.setFloat32(0, defNpBonusGain * float.getFloat32(0));
  final beforeOverkill = float.getFloat32(0);

  final overkillModifier = param.isOverkill ? toModifier(db.gameData.constData.constants.overKillNpRate) : 1.0;
  float.setFloat32(0, beforeOverkill * overkillModifier);
  return float.getFloat32(0).floor();
}

/// Referencing:
/// https://atlasacademy.github.io/fgo-docs/deeper/battle/critstars.html
int calculateStar(final StarParameters param) {
  final constData = db.gameData.constData;
  if (!constData.cardInfo.containsKey(param.currentCardType)) {
    throw 'Invalid current card type: ${param.currentCardType}';
  }

  final chainPos = param.isNp ? 1 : param.chainPos;
  final cardCorrection = constData.cardInfo[param.currentCardType]![chainPos]!.adjustCritical;

  if (!constData.cardInfo.containsKey(param.firstCardType)) {
    throw 'Invalid first card type: ${param.firstCardType}';
  }
  final firstCardBonus = param.isNp
      ? 0
      : param.isMightyChain
          ? constData.cardInfo[CardType.quick]![1]!.addCritical
          : constData.cardInfo[param.firstCardType]![1]!.addCritical;
  final criticalModifier = param.isCritical ? constData.constants.criticalStarRate : 0;

  final defenderStarRate = param.defenderStarRate;

  final cardBuff = toModifier(param.cardBuff);
  final cardResist = toModifier(param.cardResist);

  final overkillModifier = param.isOverkill ? toModifier(constData.constants.overKillStarRate) : 1;
  final overkillAdd = param.isOverkill ? constData.constants.overKillStarAdd : 0;

  // not converted to modifier since mostly just additions.
  final dropRate = ((param.attackerStarGen +
                  firstCardBonus +
                  (cardCorrection * max(1 + cardBuff - cardResist, 0)) +
                  defenderStarRate +
                  param.starGenBuff -
                  param.enemyStarGenResist +
                  criticalModifier) *
              overkillModifier +
          overkillAdd)
      .toInt();

  return min(max(dropRate, 0), constData.constants.starRateMax);
}

double toModifier(final int value) {
  return 0.001 * value;
}

class DamageParameters {
  int attack = 0;
  int damageRate = 1000;
  int totalHits = 100;
  int npSpecificAttackRate = 1000;
  SvtClass attackerClass = SvtClass.none;
  SvtClass defenderClass = SvtClass.none;
  int classAdvantage = 0;
  Attribute attackerAttribute = Attribute.void_;
  Attribute defenderAttribute = Attribute.void_;
  bool isNp = false;
  int chainPos = 1;
  CardType currentCardType = CardType.none;
  CardType firstCardType = CardType.none;
  bool isTypeChain = false;
  bool isMightyChain = false;
  bool isCritical = false;
  int cardBuff = 0;
  int cardResist = 0;
  int attackBuff = 0;
  int defenseBuff = 0;
  int specificAttackBuff = 0;
  int specificDefenseBuff = 0; // this maps to selfDamageMod, can rename after I see an instance of this buff
  int criticalDamageBuff = 0;
  int npDamageBuff = 0;
  int percentAttackBuff = 0;
  int percentDefenseBuff = 0;
  int damageAdditionBuff = 0;
  int damageReductionBuff = 0;
  double fixedRandom = 0;

  @override
  String toString() {
    return 'DamageParameters: {'
        'attack: $attack, '
        'damageRate: $damageRate, '
        'totalHits: $totalHits, '
        'npSpecificAttackRate: $npSpecificAttackRate, '
        'attackerClass: $attackerClass, '
        'defenderClass: $defenderClass, '
        'classAdvantage: $classAdvantage, '
        'attackerAttribute: $attackerAttribute, '
        'defenderAttribute: $defenderAttribute, '
        'isNp: $isNp, '
        'chainPos: $chainPos, '
        'currentCardType: $currentCardType, '
        'firstCardType: $firstCardType, '
        'isTypeChain: $isTypeChain, '
        'isMightyChain: $isMightyChain, '
        'isCritical: $isCritical, '
        'cardBuff: $cardBuff, '
        'cardResist: $cardResist, '
        'attackBuff: $attackBuff, '
        'defenseBuff: $defenseBuff, '
        'specificAttackBuff: $specificAttackBuff, '
        'specificDefenseBuff: $specificDefenseBuff, '
        'criticalDamageBuff: $criticalDamageBuff, '
        'npDamageBuff: $npDamageBuff, '
        'percentAttackBuff: $percentAttackBuff, '
        'percentDefenseBuff: $percentDefenseBuff, '
        'damageAdditionBuff: $damageAdditionBuff, '
        'damageReductionBuff: $damageReductionBuff, '
        'fixedRandom: $fixedRandom'
        '}';
  }

  DamageParameters copy() {
    return DamageParameters()
      ..attack = attack
      ..damageRate = damageRate
      ..totalHits = totalHits
      ..npSpecificAttackRate = npSpecificAttackRate
      ..attackerClass = attackerClass
      ..defenderClass = defenderClass
      ..classAdvantage = classAdvantage
      ..attackerAttribute = attackerAttribute
      ..defenderAttribute = defenderAttribute
      ..isNp = isNp
      ..chainPos = chainPos
      ..currentCardType = currentCardType
      ..firstCardType = firstCardType
      ..isTypeChain = isTypeChain
      ..isMightyChain = isMightyChain
      ..isCritical = isCritical
      ..cardBuff = cardBuff
      ..cardResist = cardResist
      ..attackBuff = attackBuff
      ..defenseBuff = defenseBuff
      ..specificAttackBuff = specificAttackBuff
      ..specificDefenseBuff = specificDefenseBuff
      ..criticalDamageBuff = criticalDamageBuff
      ..npDamageBuff = npDamageBuff
      ..percentAttackBuff = percentAttackBuff
      ..percentDefenseBuff = percentDefenseBuff
      ..damageAdditionBuff = damageAdditionBuff
      ..damageReductionBuff = damageReductionBuff
      ..fixedRandom = fixedRandom;
  }
}

class AttackNpGainParameters {
  int attackerNpCharge = 0;
  int defenderNpRate = 0;
  bool isNp = false;
  int chainPos = 1;
  CardType currentCardType = CardType.none;
  CardType firstCardType = CardType.none;
  bool isMightyChain = false;
  bool isCritical = false;
  int cardBuff = 0;
  int cardResist = 0;
  int npGainBuff = 0;
  bool isOverkill = false;

  @override
  String toString() {
    return 'AttackNpGainParameters: {'
        'attackerNpCharge: $attackerNpCharge, '
        'defenderNpRate: $defenderNpRate, '
        'isNp: $isNp, '
        'chainPos: $chainPos, '
        'currentCardType: $currentCardType, '
        'firstCardType: $firstCardType, '
        'isMightyChain: $isMightyChain, '
        'isCritical: $isCritical, '
        'cardBuff: $cardBuff, '
        'cardResist: $cardResist, '
        'npGainBuff: $npGainBuff, '
        'isOverkill: $isOverkill'
        '}';
  }

  AttackNpGainParameters copy() {
    return AttackNpGainParameters()
      ..attackerNpCharge = attackerNpCharge
      ..defenderNpRate = defenderNpRate
      ..isNp = isNp
      ..chainPos = chainPos
      ..currentCardType = currentCardType
      ..firstCardType = firstCardType
      ..isMightyChain = isMightyChain
      ..isCritical = isCritical
      ..cardBuff = cardBuff
      ..cardResist = cardResist
      ..npGainBuff = npGainBuff
      ..isOverkill = isOverkill;
  }
}

class DefendNpGainParameters {
  int defenderNpCharge = 0;
  int attackerNpRate = 0;
  int npGainBuff = 0;
  int defenseNpGainBuff = 0;
  bool isOverkill = false;

  @override
  String toString() {
    return 'DefendNpGainParameters: {'
        'defenderNpCharge: $defenderNpCharge, '
        'attackerNpRate: $attackerNpRate, '
        'npGainBuff: $npGainBuff, '
        'defenseNpGainBuff: $defenseNpGainBuff, '
        'isOverkill: $isOverkill'
        '}';
  }

  DefendNpGainParameters copy() {
    return DefendNpGainParameters()
      ..defenderNpCharge = defenderNpCharge
      ..attackerNpRate = attackerNpRate
      ..npGainBuff = npGainBuff
      ..defenseNpGainBuff = defenseNpGainBuff
      ..isOverkill = isOverkill;
  }
}

class StarParameters {
  int attackerStarGen = 0;
  int defenderStarRate = 0;
  bool isNp = false;
  int chainPos = 1;
  CardType currentCardType = CardType.none;
  CardType firstCardType = CardType.none;
  bool isMightyChain = false;
  bool isCritical = false;
  int cardBuff = 0;
  int cardResist = 0;
  int starGenBuff = 0;
  int enemyStarGenResist = 0;
  bool isOverkill = false;

  @override
  String toString() {
    return 'StarParameters: {'
        'attackerStarGen: $attackerStarGen, '
        'defenderStarRate: $defenderStarRate, '
        'isNp: $isNp, '
        'chainPos: $chainPos, '
        'currentCardType: $currentCardType, '
        'firstCardType: $firstCardType, '
        'isMightyChain: $isMightyChain, '
        'isCritical: $isCritical, '
        'cardBuff: $cardBuff, '
        'cardResist: $cardResist, '
        'starGenBuff: $starGenBuff, '
        'enemyStarGenResist: $enemyStarGenResist, '
        'isOverkill: $isOverkill'
        '}';
  }

  StarParameters copy() {
    return StarParameters()
      ..attackerStarGen = attackerStarGen
      ..defenderStarRate = defenderStarRate
      ..isNp = isNp
      ..chainPos = chainPos
      ..currentCardType = currentCardType
      ..firstCardType = firstCardType
      ..isMightyChain = isMightyChain
      ..isCritical = isCritical
      ..cardBuff = cardBuff
      ..cardResist = cardResist
      ..starGenBuff = starGenBuff
      ..isOverkill = isOverkill;
  }
}
