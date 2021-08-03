// userdata: plan etc.
part of datatypes;

enum GameServer {
  jp,
  cn,
  tw,
  en,
}

extension GameServerUtil on GameServer {
  String get localized {
    switch (this) {
      case GameServer.jp:
        return S.current.server_jp;
      case GameServer.cn:
        return S.current.server_cn;
      case GameServer.tw:
        return S.current.server_tw;
      case GameServer.en:
        return S.current.server_na;
    }
  }
}

@JsonSerializable(checked: true)
class User {
  String? key;
  String name;

  GameServer? _server;

  GameServer get server {
    if (_server == null) {
      Language lang =
          Language.getLanguage(db.userData.language) ?? Language.current;
      switch (lang) {
        case Language.eng:
          _server = GameServer.en;
          break;
        case Language.jpn:
          _server = GameServer.jp;
          break;
        case Language.chs:
          _server = GameServer.cn;
          break;
        default:
          _server = GameServer.cn;
          break;
      }
    }
    return _server!;
  }

  set server(GameServer value) => _server = value;

  @JsonKey(toJson: _servantsToJson)
  Map<int, ServantStatus> servants;

  /// Map<planNo, Map<SvtNo, SvtPlan>>
  @JsonKey(toJson: _servantPlansToJson)
  List<Map<int, ServantPlan>> servantPlans;
  int curSvtPlanNo;

  /// user own items, key: item name, value: item count
  Map<String, int> items;
  EventPlans events;

  /// ce id: status. status=0,1,2
  @JsonKey(toJson: _craftsPlanToJson)
  Map<int, int> crafts;
  Map<String, int> mysticCodes;
  Set<String> plannedSummons;
  bool isMasterGirl;

  /// milliseconds of event's startTimeJP
  int msProgress;

  // <svt_no_for_user, origin_svt_user>
  Map<int, int> duplicatedServants;

  User({
    this.key,
    String? name,
    GameServer? server,
    Map<int, ServantStatus>? servants,
    int? curSvtPlanNo,
    List<Map<int, ServantPlan>>? servantPlans,
    Map<String, int>? items,
    EventPlans? events,
    Map<int, int>? crafts,
    Map<String, int>? mysticCodes,
    Set<String>? plannedSummons,
    bool? isMasterGirl,
    int? msProgress,
    Map<int, int>? duplicatedServants,
  })  : name = name?.isNotEmpty == true ? name! : 'default',
        _server = server,
        servants = servants ?? {},
        curSvtPlanNo = curSvtPlanNo ?? 0,
        servantPlans = servantPlans ?? [],
        items = items ?? {},
        events = events ?? EventPlans(),
        crafts = crafts ?? {},
        mysticCodes = mysticCodes ?? {},
        plannedSummons = plannedSummons ?? <String>{},
        isMasterGirl = isMasterGirl ?? true,
        msProgress = msProgress ?? -1,
        duplicatedServants = duplicatedServants ?? {} {
    this.curSvtPlanNo =
        fixValidRange(this.curSvtPlanNo, 0, this.servantPlans.length);
    fillListValue(this.servantPlans, max(5, this.servantPlans.length),
        (_) => <int, ServantPlan>{});
  }

  Map<int, ServantPlan> get curSvtPlan {
    curSvtPlanNo = fixValidRange(curSvtPlanNo, 0, servantPlans.length - 1);
    return servantPlans[curSvtPlanNo];
  }

  Servant addDuplicatedForServant(Servant svt, [int? newNo]) {
    for (int no = svt.originNo * 1000 + 1;
        no < svt.originNo * 1000 + 999;
        no++) {
      if (!db.gameData.servantsWithUser.containsKey(no)) {
        duplicatedServants[no] = svt.originNo;
        final newSvt = svt.duplicate(no);
        db.gameData.servantsWithUser[no] = newSvt;
        return newSvt;
        // return
      }
    }
    return svt;
  }

  void removeDuplicatedServant(int svtNo) {
    duplicatedServants.remove(svtNo);
    servants.remove(svtNo);
    servantPlans.forEach((plans) {
      plans.remove(svtNo);
    });
    db.gameData.updateUserDuplicatedServants();
  }

  void ensurePlanLarger() {
    curSvtPlan.forEach((key, plan) {
      plan.validate(servants[key]?.curVal);
    });
  }

  ServantPlan svtPlanOf(int no) =>
      curSvtPlan.putIfAbsent(no, () => ServantPlan())..validate();

  ServantStatus svtStatusOf(int no) {
    final status = servants.putIfAbsent(no, () => ServantStatus())
      ..curVal.validate();
    final svt = db.gameData.servantsWithUser[no];

    if (svt != null &&
        status.isEmpty &&
        (svt.info.rarity <= 3 || svt.info.obtain == '活动')) {
      status.npLv = 5;
    }
    return status;
  }

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  // can be sorted before saving
  static Map<String, ServantStatus> _servantsToJson(
      Map<int, ServantStatus> data) {
    return data.map((k, e) => MapEntry(k.toString(), e))
      ..removeWhere((key, value) => value.isEmpty);
  }

  static List<Map<String, ServantPlan>> _servantPlansToJson(
      List<Map<int, ServantPlan>> data) {
    return data
        .map((e) => e.map((k, e) => MapEntry(k.toString(), e))
          ..removeWhere((key, value) => value.isEmpty))
        .toList();
  }

  static Map<String, int> _craftsPlanToJson(Map<int, int> data) {
    return data.map((k, e) => MapEntry(k.toString(), e))
      ..removeWhere((key, value) => value == 0);
  }
}

@JsonSerializable(checked: true)
class ServantStatus {
  bool get favorite => curVal.favorite;

  set favorite(bool v) => curVal.favorite = v;

  ServantPlan curVal;
  int npLv;

  /// null-not set, >=0 index, sorted from non-enhanced to enhanced
  List<int?> skillIndex; //length=3
  /// default 0, origin order in wiki
  int npIndex;

  /// priority 1-5
  int priority;

  ServantStatus({
    bool? favorite,
    ServantPlan? curVal,
    int? npLv,
    List<int?>? skillIndex,
    int? npIndex,
    int? priority,
  })  : curVal = curVal ?? ServantPlan(),
        npLv = npLv ?? 1,
        skillIndex = List.generate(3, (index) => skillIndex?.getOrNull(index)),
        npIndex = npIndex ?? 0,
        priority = priority ?? 1 {
    validate();
  }

  void validate([Servant? svt]) {
    curVal.validate();
    npLv = fixValidRange(npLv, 1, 5);
    npIndex = fixValidRange(
        npIndex, 0, svt == null ? null : svt.lNobelPhantasm.length - 1);
    int skillNum = svt?.lActiveSkills.length ?? 3;
    skillIndex.length = skillNum;
    for (int i = 0; i < skillNum; i++) {
      if (skillIndex[i] != null) {
        if (svt != null &&
            svt.lActiveSkills.getOrNull(skillIndex[i]!) == null) {
          skillIndex[i] = null;
        }
      }
    }
    priority = fixValidRange(priority, 1, 5);
  }

  void reset() {
    curVal.reset();
    npLv = 1;
    priority = 1;
    resetEnhancement();
  }

  void resetEnhancement() {
    skillIndex.fillRange(0, 3, null);
    npIndex = 0;
  }

  bool get isEmpty {
    return curVal.isEmpty && (npLv == 1 || npLv == 5) && priority == 1;
  }

  factory ServantStatus.fromJson(Map<String, dynamic> data) =>
      _$ServantStatusFromJson(data);

  Map<String, dynamic> toJson() => _$ServantStatusToJson(this);
}

@JsonSerializable(checked: true)
class ServantPlan {
  /// TODO: how to remove it and use [ServantStatus.favorite] instead?
  bool favorite;
  int ascension;
  List<int> skills; // length 3
  List<int> appendSkills; // length 3
  List<int> dress;
  int grail;

  /// 流星のフォウくん/日輪のフォウくん, 1000-2000
  int fouHp;
  int fouAtk;

  ServantPlan({
    bool? favorite,
    int? ascension,
    List<int>? skills,
    List<int>? dress,
    List<int>? appendSkills,
    int? grail,
    int? fouHp,
    int? fouAtk,
  })  : favorite = favorite ?? false,
        ascension = ascension ?? 0,
        skills = List.generate(3, (index) => skills?.getOrNull(index) ?? 1),
        dress = List.generate(
            dress?.length ?? 0, (index) => dress?.getOrNull(index) ?? 0),
        appendSkills =
            List.generate(3, (index) => appendSkills?.getOrNull(index) ?? 1),
        grail = grail ?? 0,
        fouHp = fouHp ?? 0,
        fouAtk = fouAtk ?? 0 {
    validate();
  }

  int get shownFouHp => fouHp * 20;

  int get shownFouAtk => fouAtk * 20;

  void reset() {
    favorite = false;
    ascension = 0;
    skills.fillRange(0, 3, 1);
    dress.fillRange(0, dress.length, 0);
    appendSkills.fillRange(0, 3, 1);
    grail = 0;
    fouHp = fouAtk = 0;
  }

  bool get isEmpty {
    return favorite == false &&
        ascension == 0 &&
        skills.every((e) => e == 1) &&
        dress.every((e) => e == 0) &&
        appendSkills.every((e) => e == 1) &&
        grail == 0 &&
        fouHp == 0 &&
        fouAtk == 0;
  }

  void setMax({int skill = 10}) {
    // not change grail lv
    favorite = true;
    ascension = 4;
    skills.fillRange(0, 3, skill);
    dress.fillRange(0, dress.length, 1);
    // appendSkills.fillRange(0, 3, skill);
    // grail = grail;
    // fouHp, fouAtk
  }

  void fixDressLength(int length, [int fill = 0]) {
    fillListValue(dress, length, (_) => fill);
  }

  void validate([ServantPlan? lowerPlan]) {
    lowerPlan?.validate();
    ascension = fixValidRange(ascension, lowerPlan?.ascension ?? 0, 4);
    for (int i = 0; i < skills.length; i++) {
      skills[i] = fixValidRange(skills[i], lowerPlan?.skills[i] ?? 1, 10);
    }
    for (int i = 0; i < appendSkills.length; i++) {
      appendSkills[i] =
          fixValidRange(appendSkills[i], lowerPlan?.appendSkills[i] ?? 1, 10);
    }
    for (int i = 0; i < dress.length; i++) {
      dress[i] = fixValidRange(dress[i], lowerPlan?.dress.getOrNull(i) ?? 0, 1);
    }
    // check grail max limit when used
    grail = fixValidRange(grail, lowerPlan?.grail ?? 0);
    fouHp = fixValidRange(fouHp, lowerPlan?.fouHp ?? 0, 50);
    fouAtk = fixValidRange(fouAtk, lowerPlan?.fouAtk ?? 0, 50);
  }

  factory ServantPlan.fromJson(Map<String, dynamic> data) =>
      _$ServantPlanFromJson(data)..validate();

  Map<String, dynamic> toJson() => _$ServantPlanToJson(this);

  ServantPlan copyWith({
    bool? favorite,
    int? ascension,
    List<int>? skills,
    List<int>? dress,
    List<int>? appendSkills,
    int? grail,
    int? fouHp,
    int? fouAtk,
  }) {
    return ServantPlan(
      favorite: favorite ?? this.favorite,
      ascension: ascension ?? this.ascension,
      skills: skills ?? this.skills,
      dress: dress ?? this.dress,
      appendSkills: appendSkills ?? this.appendSkills,
      grail: grail ?? this.grail,
      fouHp: fouHp ?? this.fouHp,
      fouAtk: fouAtk ?? this.fouAtk,
    );
  }

  void copyFrom(ServantPlan other) {
    favorite = other.favorite;
    ascension = other.ascension;
    skills = List.from(other.skills);
    dress = List.from(other.dress);
    appendSkills = List.from(other.appendSkills);
    grail = other.grail;
    fouHp = other.fouHp;
    fouAtk = other.fouAtk;
  }

  static ServantPlan from(ServantPlan other) => ServantPlan()..copyFrom(other);
}

@JsonSerializable(checked: true)
class EventPlans {
  @JsonKey(toJson: _limitEventsToJson)
  Map<String, LimitEventPlan> limitEvents;

  /// {'chapter 1': [drops_switch,rewards_switch]}
  @JsonKey(toJson: _mainRecordsToJson)
  Map<String, List<bool>> mainRecords;

  ///{'monthCn': [num1, num2, num3]}
  @JsonKey(toJson: _exchangeTicketsToJson)
  Map<String, List<int>> exchangeTickets;

  Map<String, CampaignPlan> campaigns;

  EventPlans({
    Map<String, LimitEventPlan>? limitEvents,
    Map<String, List<bool>>? mainRecords,
    Map<String, List<int>>? exchangeTickets,
    Map<String, CampaignPlan>? campaigns,
  })  : limitEvents = limitEvents ?? {},
        mainRecords = Map.fromIterable((mainRecords ?? {}).entries,
            key: (e) => e.key,
            value: (e) => List.generate(2,
                (index) => (e.value as List<bool>).getOrNull(index) ?? false)),
        exchangeTickets = Map.fromIterable((exchangeTickets ?? {}).entries,
            key: (e) => e.key,
            value: (e) => List.generate(
                3, (index) => (e.value as List<int>).getOrNull(index) ?? 0)),
        campaigns = campaigns ?? {};

  LimitEventPlan limitEventOf(String indexKey) =>
      limitEvents.putIfAbsent(indexKey, () => LimitEventPlan());

  List<bool> mainRecordOf(String indexKey) =>
      mainRecords.putIfAbsent(indexKey, () => [false, false]);

  List<int> exchangeTicketOf(String indexKey) =>
      exchangeTickets.putIfAbsent(indexKey, () => [0, 0, 0]);

  CampaignPlan campaignEventPlanOf(String indexKey) =>
      campaigns.putIfAbsent(indexKey, () => CampaignPlan());

  factory EventPlans.fromJson(Map<String, dynamic> data) =>
      _$EventPlansFromJson(data);

  Map<String, dynamic> toJson() => _$EventPlansToJson(this);

  static Map<String, LimitEventPlan> _limitEventsToJson(
      Map<String, LimitEventPlan> data) {
    return Map.of(data)..removeWhere((key, value) => value.isEmpty);
  }

  static Map<String, List<bool>> _mainRecordsToJson(
      Map<String, List<bool>> data) {
    return Map<String, List<bool>>.of(data)
      ..removeWhere((key, value) => value.every((e) => e == false));
  }

  static Map<String, List<int>> _exchangeTicketsToJson(
      Map<String, List<int>> data) {
    return Map.of(data)
      ..removeWhere((key, value) => value.every((e) => e == 0));
  }
}

@JsonSerializable(checked: true)
class LimitEventPlan {
  bool enable;
  bool rerun;
  int lottery;
  Map<String, int> extra;

  LimitEventPlan({
    bool? enable,
    bool? rerun,
    int? lottery,
    Map<String, int>? extra,
  })  : enable = enable ?? false,
        rerun = rerun ?? true,
        lottery = lottery ?? 0,
        extra = extra ?? {};

  bool get isEmpty {
    return !enable &&
        rerun &&
        lottery == 0 &&
        (extra.isEmpty || extra.values.every((e) => e == 0));
  }

  factory LimitEventPlan.fromJson(Map<String, dynamic> data) =>
      _$LimitEventPlanFromJson(data);

  Map<String, dynamic> toJson() => _$LimitEventPlanToJson(this);
}

@JsonSerializable(checked: true)
class CampaignPlan {
  bool enable;
  bool rerun;

  CampaignPlan({
    bool? enable,
    bool? rerun,
  })  : enable = enable ?? false,
        rerun = rerun ?? true;

  factory CampaignPlan.fromJson(Map<String, dynamic> data) =>
      _$CampaignPlanFromJson(data);

  Map<String, dynamic> toJson() => _$CampaignPlanToJson(this);
}
