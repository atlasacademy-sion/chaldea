// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../models/gamedata/ai.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NiceAiCollection _$NiceAiCollectionFromJson(Map json) => NiceAiCollection(
      mainAis: (json['mainAis'] as List<dynamic>?)
              ?.map((e) => NiceAi.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      relatedAis: (json['relatedAis'] as List<dynamic>?)
              ?.map((e) => NiceAi.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      relatedQuests: (json['relatedQuests'] as List<dynamic>?)
              ?.map((e) => StageLink.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NiceAiCollectionToJson(NiceAiCollection instance) => <String, dynamic>{
      'mainAis': instance.mainAis.map((e) => e.toJson()).toList(),
      'relatedAis': instance.relatedAis.map((e) => e.toJson()).toList(),
      'relatedQuests': instance.relatedQuests.map((e) => e.toJson()).toList(),
    };

NiceAi _$NiceAiFromJson(Map json) => NiceAi(
      id: json['id'] as int,
      idx: json['idx'] as int,
      actNumInt: json['actNumInt'] as int,
      actNum: $enumDecodeNullable(_$NiceAiActNumEnumMap, json['actNum']) ?? NiceAiActNum.unknown,
      priority: json['priority'] as int,
      probability: json['probability'] as int,
      cond: $enumDecodeNullable(_$NiceAiCondEnumMap, json['cond']) ?? NiceAiCond.none,
      condNegative: json['condNegative'] as bool? ?? false,
      vals: (json['vals'] as List<dynamic>?)?.map((e) => e as int).toList() ?? const [],
      aiAct: NiceAiAct.fromJson(Map<String, dynamic>.from(json['aiAct'] as Map)),
      avals: (json['avals'] as List<dynamic>?)?.map((e) => e as int).toList() ?? const [],
      parentAis: (json['parentAis'] as Map?)?.map(
            (k, e) => MapEntry($enumDecode(_$AiTypeEnumMap, k), (e as List<dynamic>).map((e) => e as int).toList()),
          ) ??
          const {},
      infoText: json['infoText'] as String? ?? '',
      timing: json['timing'] as int?,
      timingDescription: $enumDecodeNullable(_$AiTimingEnumMap, json['timingDescription']),
    );

Map<String, dynamic> _$NiceAiToJson(NiceAi instance) => <String, dynamic>{
      'id': instance.id,
      'idx': instance.idx,
      'actNumInt': instance.actNumInt,
      'actNum': _$NiceAiActNumEnumMap[instance.actNum]!,
      'priority': instance.priority,
      'probability': instance.probability,
      'cond': _$NiceAiCondEnumMap[instance.cond]!,
      'condNegative': instance.condNegative,
      'vals': instance.vals,
      'aiAct': instance.aiAct.toJson(),
      'avals': instance.avals,
      'parentAis': instance.parentAis.map((k, e) => MapEntry(_$AiTypeEnumMap[k]!, e)),
      'infoText': instance.infoText,
      'timing': instance.timing,
      'timingDescription': _$AiTimingEnumMap[instance.timingDescription],
    };

const _$NiceAiActNumEnumMap = {
  NiceAiActNum.nomal: 'nomal',
  NiceAiActNum.anytime: 'anytime',
  NiceAiActNum.reactionPlyaerSkill: 'reactionPlyaerSkill',
  NiceAiActNum.reactionEnemyturnStart: 'reactionEnemyturnStart',
  NiceAiActNum.reactionEnemyturnEnd: 'reactionEnemyturnEnd',
  NiceAiActNum.reactionDead: 'reactionDead',
  NiceAiActNum.reactionPlayeractionend: 'reactionPlayeractionend',
  NiceAiActNum.reactionWavestart: 'reactionWavestart',
  NiceAiActNum.maxnp: 'maxnp',
  NiceAiActNum.afterTurnPlayerEnd: 'afterTurnPlayerEnd',
  NiceAiActNum.usenpTarget: 'usenpTarget',
  NiceAiActNum.reactionTurnstart: 'reactionTurnstart',
  NiceAiActNum.reactionPlayeractionstart: 'reactionPlayeractionstart',
  NiceAiActNum.reactionEntryUnit: 'reactionEntryUnit',
  NiceAiActNum.reactionBeforeResurrection: 'reactionBeforeResurrection',
  NiceAiActNum.reactionBeforeDead: 'reactionBeforeDead',
  NiceAiActNum.shiftServantAfter: 'shiftServantAfter',
  NiceAiActNum.reactionBeforeMoveWave: 'reactionBeforeMoveWave',
  NiceAiActNum.reactionEnemyTurnStartPriority: 'reactionEnemyTurnStartPriority',
  NiceAiActNum.reactionEnemyTurnEndPriority: 'reactionEnemyTurnEndPriority',
  NiceAiActNum.unknown: 'unknown',
};

const _$NiceAiCondEnumMap = {
  NiceAiCond.none: 'none',
  NiceAiCond.hpHigher: 'hpHigher',
  NiceAiCond.hpLower: 'hpLower',
  NiceAiCond.actcount: 'actcount',
  NiceAiCond.actcountMultiple: 'actcountMultiple',
  NiceAiCond.turn: 'turn',
  NiceAiCond.turnMultiple: 'turnMultiple',
  NiceAiCond.beforeActId: 'beforeActId',
  NiceAiCond.beforeActType: 'beforeActType',
  NiceAiCond.beforeNotActId: 'beforeNotActId',
  NiceAiCond.beforeNotActType: 'beforeNotActType',
  NiceAiCond.checkSelfBuff: 'checkSelfBuff',
  NiceAiCond.checkSelfIndividuality: 'checkSelfIndividuality',
  NiceAiCond.checkPtBuff: 'checkPtBuff',
  NiceAiCond.checkPtIndividuality: 'checkPtIndividuality',
  NiceAiCond.checkOpponentBuff: 'checkOpponentBuff',
  NiceAiCond.checkOpponentIndividuality: 'checkOpponentIndividuality',
  NiceAiCond.checkSelfBuffIndividuality: 'checkSelfBuffIndividuality',
  NiceAiCond.checkPtBuffIndividuality: 'checkPtBuffIndividuality',
  NiceAiCond.checkOpponentBuffIndividuality: 'checkOpponentBuffIndividuality',
  NiceAiCond.checkSelfNpturn: 'checkSelfNpturn',
  NiceAiCond.checkPtLowerNpturn: 'checkPtLowerNpturn',
  NiceAiCond.checkOpponentHeightNpgauge: 'checkOpponentHeightNpgauge',
  NiceAiCond.actcountThisturn: 'actcountThisturn',
  NiceAiCond.checkPtHpHigher: 'checkPtHpHigher',
  NiceAiCond.checkPtHpLower: 'checkPtHpLower',
  NiceAiCond.checkSelfNotBuffIndividuality: 'checkSelfNotBuffIndividuality',
  NiceAiCond.turnAndActcountThisturn: 'turnAndActcountThisturn',
  NiceAiCond.fieldturn: 'fieldturn',
  NiceAiCond.fieldturnMultiple: 'fieldturnMultiple',
  NiceAiCond.checkPtLowerTdturn: 'checkPtLowerTdturn',
  NiceAiCond.raidHpHigher: 'raidHpHigher',
  NiceAiCond.raidHpLower: 'raidHpLower',
  NiceAiCond.raidCountHigher: 'raidCountHigher',
  NiceAiCond.raidCountLower: 'raidCountLower',
  NiceAiCond.raidCountValueHigher: 'raidCountValueHigher',
  NiceAiCond.raidCountValueLower: 'raidCountValueLower',
  NiceAiCond.checkSpace: 'checkSpace',
  NiceAiCond.turnHigher: 'turnHigher',
  NiceAiCond.turnLower: 'turnLower',
  NiceAiCond.charactorTurnHigher: 'charactorTurnHigher',
  NiceAiCond.charactorTurnLower: 'charactorTurnLower',
  NiceAiCond.countAlivePt: 'countAlivePt',
  NiceAiCond.countAliveOpponent: 'countAliveOpponent',
  NiceAiCond.countPtRestHigher: 'countPtRestHigher',
  NiceAiCond.countPtRestLower: 'countPtRestLower',
  NiceAiCond.countOpponentRestHigher: 'countOpponentRestHigher',
  NiceAiCond.countOpponentRestLower: 'countOpponentRestLower',
  NiceAiCond.countItemHigher: 'countItemHigher',
  NiceAiCond.countItemLower: 'countItemLower',
  NiceAiCond.checkSelfBuffcountIndividuality: 'checkSelfBuffcountIndividuality',
  NiceAiCond.checkPtBuffcountIndividuality: 'checkPtBuffcountIndividuality',
  NiceAiCond.checkSelfBuffActive: 'checkSelfBuffActive',
  NiceAiCond.checkPtBuffActive: 'checkPtBuffActive',
  NiceAiCond.checkOpponentBuffActive: 'checkOpponentBuffActive',
  NiceAiCond.countEnemyCommandSpellHigher: 'countEnemyCommandSpellHigher',
  NiceAiCond.checkPtAllIndividuality: 'checkPtAllIndividuality',
  NiceAiCond.checkOpponentAllIndividuality: 'checkOpponentAllIndividuality',
  NiceAiCond.starHigher: 'starHigher',
  NiceAiCond.starLower: 'starLower',
  NiceAiCond.checkOpponentHpHigher: 'checkOpponentHpHigher',
  NiceAiCond.checkOpponentHpLower: 'checkOpponentHpLower',
  NiceAiCond.checkTargetPosition: 'checkTargetPosition',
  NiceAiCond.checkSelfBuffActiveAndPassiveIndividuality: 'checkSelfBuffActiveAndPassiveIndividuality',
  NiceAiCond.checkPtBuffActiveAndPassiveIndividuality: 'checkPtBuffActiveAndPassiveIndividuality',
  NiceAiCond.checkOpponentBuffActiveAndPassiveIndividuality: 'checkOpponentBuffActiveAndPassiveIndividuality',
  NiceAiCond.checkPtAllBuff: 'checkPtAllBuff',
  NiceAiCond.checkOpponentAllBuff: 'checkOpponentAllBuff',
  NiceAiCond.checkPtAllBuffIndividuality: 'checkPtAllBuffIndividuality',
  NiceAiCond.checkOpponentAllBuffIndividuality: 'checkOpponentAllBuffIndividuality',
  NiceAiCond.countAlivePtAll: 'countAlivePtAll',
  NiceAiCond.countAliveOpponentAll: 'countAliveOpponentAll',
  NiceAiCond.checkPtAllBuffActive: 'checkPtAllBuffActive',
  NiceAiCond.checkOpponentAllBuffActive: 'checkOpponentAllBuffActive',
  NiceAiCond.countHigherBuffIndividualitySumPt: 'countHigherBuffIndividualitySumPt',
  NiceAiCond.countHigherBuffIndividualitySumPtAll: 'countHigherBuffIndividualitySumPtAll',
  NiceAiCond.countHigherBuffIndividualitySumOpponent: 'countHigherBuffIndividualitySumOpponent',
  NiceAiCond.countHigherBuffIndividualitySumOpponentAll: 'countHigherBuffIndividualitySumOpponentAll',
  NiceAiCond.countHigherBuffIndividualitySumSelf: 'countHigherBuffIndividualitySumSelf',
  NiceAiCond.countLowerBuffIndividualitySumPt: 'countLowerBuffIndividualitySumPt',
  NiceAiCond.countLowerBuffIndividualitySumPtAll: 'countLowerBuffIndividualitySumPtAll',
  NiceAiCond.countLowerBuffIndividualitySumOpponent: 'countLowerBuffIndividualitySumOpponent',
  NiceAiCond.countLowerBuffIndividualitySumOpponentAll: 'countLowerBuffIndividualitySumOpponentAll',
  NiceAiCond.countLowerBuffIndividualitySumSelf: 'countLowerBuffIndividualitySumSelf',
  NiceAiCond.countEqualBuffIndividualitySumPt: 'countEqualBuffIndividualitySumPt',
  NiceAiCond.countEqualBuffIndividualitySumPtAll: 'countEqualBuffIndividualitySumPtAll',
  NiceAiCond.countEqualBuffIndividualitySumOpponent: 'countEqualBuffIndividualitySumOpponent',
  NiceAiCond.countEqualBuffIndividualitySumOpponentAll: 'countEqualBuffIndividualitySumOpponentAll',
  NiceAiCond.countEqualBuffIndividualitySumSelf: 'countEqualBuffIndividualitySumSelf',
  NiceAiCond.existIndividualityOpponentFront: 'existIndividualityOpponentFront',
  NiceAiCond.existIndividualityOpponentCenter: 'existIndividualityOpponentCenter',
  NiceAiCond.existIndividualityOpponentBack: 'existIndividualityOpponentBack',
  NiceAiCond.totalCountHigherIndividualityPt: 'totalCountHigherIndividualityPt',
  NiceAiCond.totalCountHigherIndividualityPtAll: 'totalCountHigherIndividualityPtAll',
  NiceAiCond.totalCountHigherIndividualityOpponent: 'totalCountHigherIndividualityOpponent',
  NiceAiCond.totalCountHigherIndividualityOpponentAll: 'totalCountHigherIndividualityOpponentAll',
  NiceAiCond.totalCountHigherIndividualityAllField: 'totalCountHigherIndividualityAllField',
  NiceAiCond.totalCountLowerIndividualityPt: 'totalCountLowerIndividualityPt',
  NiceAiCond.totalCountLowerIndividualityPtAll: 'totalCountLowerIndividualityPtAll',
  NiceAiCond.totalCountLowerIndividualityOpponent: 'totalCountLowerIndividualityOpponent',
  NiceAiCond.totalCountLowerIndividualityOpponentAll: 'totalCountLowerIndividualityOpponentAll',
  NiceAiCond.totalCountLowerIndividualityAllField: 'totalCountLowerIndividualityAllField',
  NiceAiCond.totalCountEqualIndividualityPt: 'totalCountEqualIndividualityPt',
  NiceAiCond.totalCountEqualIndividualityPtAll: 'totalCountEqualIndividualityPtAll',
  NiceAiCond.totalCountEqualIndividualityOpponent: 'totalCountEqualIndividualityOpponent',
  NiceAiCond.totalCountEqualIndividualityOpponentAll: 'totalCountEqualIndividualityOpponentAll',
  NiceAiCond.totalCountEqualIndividualityAllField: 'totalCountEqualIndividualityAllField',
  NiceAiCond.ptFrontDeadEqual: 'ptFrontDeadEqual',
  NiceAiCond.ptCenterDeadEqual: 'ptCenterDeadEqual',
  NiceAiCond.ptBackDeadEqual: 'ptBackDeadEqual',
  NiceAiCond.countHigherIndividualityPtFront: 'countHigherIndividualityPtFront',
  NiceAiCond.countHigherIndividualityPtCenter: 'countHigherIndividualityPtCenter',
  NiceAiCond.countHigherIndividualityPtBack: 'countHigherIndividualityPtBack',
  NiceAiCond.countHigherIndividualityOpponentFront: 'countHigherIndividualityOpponentFront',
  NiceAiCond.countHigherIndividualityOpponentCenter: 'countHigherIndividualityOpponentCenter',
  NiceAiCond.countHigherIndividualityOpponentBack: 'countHigherIndividualityOpponentBack',
  NiceAiCond.countLowerIndividualityPtFront: 'countLowerIndividualityPtFront',
  NiceAiCond.countLowerIndividualityPtCenter: 'countLowerIndividualityPtCenter',
  NiceAiCond.countLowerIndividualityPtBack: 'countLowerIndividualityPtBack',
  NiceAiCond.countLowerIndividualityOpponentFront: 'countLowerIndividualityOpponentFront',
  NiceAiCond.countLowerIndividualityOpponentCenter: 'countLowerIndividualityOpponentCenter',
  NiceAiCond.countLowerIndividualityOpponentBack: 'countLowerIndividualityOpponentBack',
  NiceAiCond.countEqualIndividualityPtFront: 'countEqualIndividualityPtFront',
  NiceAiCond.countEqualIndividualityPtCenter: 'countEqualIndividualityPtCenter',
  NiceAiCond.countEqualIndividualityPtBack: 'countEqualIndividualityPtBack',
  NiceAiCond.countEqualIndividualityOpponentFront: 'countEqualIndividualityOpponentFront',
  NiceAiCond.countEqualIndividualityOpponentCenter: 'countEqualIndividualityOpponentCenter',
  NiceAiCond.countEqualIndividualityOpponentBack: 'countEqualIndividualityOpponentBack',
  NiceAiCond.checkPrecedingEnemy: 'checkPrecedingEnemy',
  NiceAiCond.countHigherRemainTurn: 'countHigherRemainTurn',
  NiceAiCond.countLowerRemainTurn: 'countLowerRemainTurn',
  NiceAiCond.countHigherAi171: 'countHigherAi171',
  NiceAiCond.countLowerAi172: 'countLowerAi172',
  NiceAiCond.countEqualAi173: 'countEqualAi173',
  NiceAiCond.checkAi174: 'checkAi174',
  NiceAiCond.checkSelfNpturnHigher: 'checkSelfNpturnHigher',
  NiceAiCond.checkSelfNpturnLower: 'checkSelfNpturnLower',
  NiceAiCond.checkUseSkillThisturn: 'checkUseSkillThisturn',
  NiceAiCond.countChainHigher: 'countChainHigher',
  NiceAiCond.countChainLower: 'countChainLower',
  NiceAiCond.countChainEqual: 'countChainEqual',
  NiceAiCond.checkSelectChain: 'checkSelectChain',
  NiceAiCond.countPlayerNpHigher: 'countPlayerNpHigher',
  NiceAiCond.countPlayerNpLower: 'countPlayerNpLower',
  NiceAiCond.countPlayerNpEqual: 'countPlayerNpEqual',
  NiceAiCond.countPlayerSkillHigher: 'countPlayerSkillHigher',
  NiceAiCond.countPlayerSkillLower: 'countPlayerSkillLower',
  NiceAiCond.countPlayerSkillEqual: 'countPlayerSkillEqual',
  NiceAiCond.countPlayerSkillHigherIncludeMasterSkill: 'countPlayerSkillHigherIncludeMasterSkill',
  NiceAiCond.countPlayerSkillLowerIncludeMasterSkill: 'countPlayerSkillLowerIncludeMasterSkill',
  NiceAiCond.countPlayerSkillEqualIncludeMasterSkill: 'countPlayerSkillEqualIncludeMasterSkill',
  NiceAiCond.totalTurnHigher: 'totalTurnHigher',
  NiceAiCond.totalTurnLower: 'totalTurnLower',
  NiceAiCond.totalTurnEqual: 'totalTurnEqual',
};

const _$AiTypeEnumMap = {
  AiType.svt: 'svt',
  AiType.field: 'field',
};

const _$AiTimingEnumMap = {
  AiTiming.dead: 'dead',
  AiTiming.turnEnemyStart: 'turnEnemyStart',
  AiTiming.turnEnemyEnd: 'turnEnemyEnd',
  AiTiming.turnPlayerStart: 'turnPlayerStart',
  AiTiming.turnPlayerEnd: 'turnPlayerEnd',
  AiTiming.waveStart: 'waveStart',
  AiTiming.turnStart: 'turnStart',
  AiTiming.unknown: 'unknown',
};

NiceAiAct _$NiceAiActFromJson(Map json) => NiceAiAct(
      id: json['id'] as int,
      type: $enumDecodeNullable(_$NiceAiActTypeEnumMap, json['type']) ?? NiceAiActType.none,
      target: $enumDecodeNullable(_$NiceAiActTargetEnumMap, json['target']) ?? NiceAiActTarget.none,
      targetIndividuality: (json['targetIndividuality'] as List<dynamic>?)
              ?.map((e) => NiceTrait.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      skillId: json['skillId'] as int?,
      skillLv: json['skillLv'] as int?,
      skill: json['skill'] == null ? null : NiceSkill.fromJson(Map<String, dynamic>.from(json['skill'] as Map)),
      noblePhantasmId: json['noblePhantasmId'] as int?,
      noblePhantasmLv: json['noblePhantasmLv'] as int?,
      noblePhantasmOc: json['noblePhantasmOc'] as int?,
      noblePhantasm: json['noblePhantasm'] == null
          ? null
          : NiceTd.fromJson(Map<String, dynamic>.from(json['noblePhantasm'] as Map)),
    );

Map<String, dynamic> _$NiceAiActToJson(NiceAiAct instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$NiceAiActTypeEnumMap[instance.type]!,
      'target': _$NiceAiActTargetEnumMap[instance.target]!,
      'targetIndividuality': instance.targetIndividuality.map((e) => e.toJson()).toList(),
      'skillId': instance.skillId,
      'skillLv': instance.skillLv,
      'skill': instance.skill?.toJson(),
      'noblePhantasmId': instance.noblePhantasmId,
      'noblePhantasmLv': instance.noblePhantasmLv,
      'noblePhantasmOc': instance.noblePhantasmOc,
      'noblePhantasm': instance.noblePhantasm?.toJson(),
    };

const _$NiceAiActTypeEnumMap = {
  NiceAiActType.none: 'none',
  NiceAiActType.random: 'random',
  NiceAiActType.attack: 'attack',
  NiceAiActType.skillRandom: 'skillRandom',
  NiceAiActType.skill1: 'skill1',
  NiceAiActType.skill2: 'skill2',
  NiceAiActType.skill3: 'skill3',
  NiceAiActType.attackA: 'attackA',
  NiceAiActType.attackB: 'attackB',
  NiceAiActType.attackQ: 'attackQ',
  NiceAiActType.attackACritical: 'attackACritical',
  NiceAiActType.attackBCritical: 'attackBCritical',
  NiceAiActType.attackQCritical: 'attackQCritical',
  NiceAiActType.attackCritical: 'attackCritical',
  NiceAiActType.skillId: 'skillId',
  NiceAiActType.skillIdCheckbuff: 'skillIdCheckbuff',
  NiceAiActType.resurrection: 'resurrection',
  NiceAiActType.playMotion: 'playMotion',
  NiceAiActType.message: 'message',
  NiceAiActType.messageGroup: 'messageGroup',
  NiceAiActType.noblePhantasm: 'noblePhantasm',
  NiceAiActType.battleEnd: 'battleEnd',
  NiceAiActType.loseEnd: 'loseEnd',
  NiceAiActType.battleEndNotRelatedSurvivalStatus: 'battleEndNotRelatedSurvivalStatus',
  NiceAiActType.changeThinking: 'changeThinking',
};

const _$NiceAiActTargetEnumMap = {
  NiceAiActTarget.none: 'none',
  NiceAiActTarget.random: 'random',
  NiceAiActTarget.hpHigher: 'hpHigher',
  NiceAiActTarget.hpLower: 'hpLower',
  NiceAiActTarget.npturnLower: 'npturnLower',
  NiceAiActTarget.npgaugeHigher: 'npgaugeHigher',
  NiceAiActTarget.revenge: 'revenge',
  NiceAiActTarget.individualityActive: 'individualityActive',
  NiceAiActTarget.buffActive: 'buffActive',
  NiceAiActTarget.front: 'front',
  NiceAiActTarget.center: 'center',
  NiceAiActTarget.back: 'back',
};
