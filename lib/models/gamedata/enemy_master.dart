import '../../app/app.dart';
import '_helper.dart';
import 'mappings.dart';

part '../../generated/models/gamedata/enemy_master.g.dart';

@JsonSerializable()
class EnemyMaster with RouteInfo {
  int id;
  String name;
  List<EnemyMasterBattle> battles;
  EnemyMaster({
    required this.id,
    this.name = "",
    this.battles = const [],
  });

  Transl<String, String> get lName {
    String name = this.name;
    if (name.isEmpty) name = 'Master $id';
    return Transl.miscScope('master_name')(name);
  }

  factory EnemyMaster.fromJson(Map<String, dynamic> json) => _$EnemyMasterFromJson(json);

  Map<String, dynamic> toJson() => _$EnemyMasterToJson(this);

  @override
  String get route => Routes.enemyMasterI(id);
}

@JsonSerializable()
class EnemyMasterBattle {
  int id;
  // int enemyMasterId;
  String face;
  String figure;
  String commandSpellIcon;
  int maxCommandSpell;
  // int offsetX;
  // int offsetY;
  // Map script;
  List<String> cutin;
  EnemyMasterBattle({
    required this.id,
    required this.face,
    required this.figure,
    required this.commandSpellIcon,
    required this.maxCommandSpell,
    this.cutin = const [],
  });

  factory EnemyMasterBattle.fromJson(Map<String, dynamic> json) => _$EnemyMasterBattleFromJson(json);

  Map<String, dynamic> toJson() => _$EnemyMasterBattleToJson(this);
}
