part of datatypes;

@JsonSerializable(checked: true)
class SaintQuartzPlan {
  int curSQ;
  int curTicket;
  int curApple;

  // login
  DateTime startDate;
  DateTime endDate;
  int accLogin = 0;
  int continuousLogin = 1;

  // event, in days
  int eventDateDelta;

  // mission
  bool weeklyMission;
  Map<int, bool> extraMissions;
  bool minusPlannedBanner;

  SaintQuartzPlan({
    int? curSQ,
    int? curTicket,
    int? curApple,
    DateTime? startDate,
    DateTime? endDate,
    int? accLogin,
    int? continuousLogin,
    int? eventDateDelta,
    bool? weeklyMission,
    Map<int, bool>? missions,
    bool? minusPlannedBanner,
  })  : curSQ = curSQ ?? 0,
        curTicket = curTicket ?? 0,
        curApple = curApple ?? 0,
        startDate = startDate ?? DateUtils.dateOnly(DateTime.now()),
        endDate = endDate ?? DateUtils.dateOnly(DateTime.now()),
        accLogin = accLogin ?? 1,
        continuousLogin = continuousLogin ?? 1,
        eventDateDelta = eventDateDelta ?? 0,
        weeklyMission = weeklyMission ?? false,
        extraMissions = missions ?? {},
        minusPlannedBanner = minusPlannedBanner ?? true {
    validate();
  }

  void validate() {
    continuousLogin = fixValidRange(continuousLogin, 1, 7);
    eventDateDelta = fixValidRange(eventDateDelta, 0);
    if (!endDate.isAfter(startDate)) {
      endDate = DateUtils.addDaysToDate(startDate, 365);
    }
  }

  bool isInRange(DateTime? jp) {
    if (jp == null) return false;
    final _date =
        DateUtils.dateOnly(DateUtils.addDaysToDate(jp, eventDateDelta));
    return !_date.isBefore(startDate) && !_date.isAfter(endDate);
  }

  factory SaintQuartzPlan.fromJson(Map<String, dynamic> data) =>
      _$SaintQuartzPlanFromJson(data);

  Map<String, dynamic> toJson() => _$SaintQuartzPlanToJson(this);

  List<SQDayDetail> solution = [];

  List<SQDayDetail> solve() {
    print('solving SQ plan');
    validate();
    Map<String, SQDayDetail> dataMap = {};
    dataMap[startDate.toDateString()] = SQDayDetail(
        date: startDate,
        accLogin: accLogin,
        accSQ: curApple,
        accTicket: curTicket,
        accApple: curApple.toDouble(),
        events: ['Starting']);
    for (int day = 1; day <= endDate.difference(startDate).inDays; day++) {
      final date = DateUtils.dateOnly(DateUtils.addDaysToDate(startDate, day));
      int sq = 0, ticket = 0;
      double apple = 0;
      // daily login: 2(1), 4(1), 6(2), 7(1 tickets), Mon.(21=3)
      // 50 days: +30
      // 1st of month: 5 tickets
      int _continuousLogin = (this.continuousLogin + day - 1) % 7 + 1;
      if (_continuousLogin == 2 || _continuousLogin == 4) {
        sq += 1;
      } else if (_continuousLogin == 6) {
        sq += 2;
      } else if (_continuousLogin == 7) {
        ticket += 1;
      } else if (date.weekday == 1 && weeklyMission) {
        sq += 3;
      }
      int _accLogin = this.accLogin + day;
      if (_accLogin % 50 == 0) {
        sq += 30;
      }
      dataMap[date.toDateString()] = SQDayDetail(
        date: date,
        accLogin: _accLogin,
        continuousLogin: _continuousLogin,
        addSQ: sq,
        addTicket: ticket,
        addApple: apple,
      );
    }
    // check event
    void _checkEvent({
      EventBase? event,
      DateTime? startDate,
      Map<String, int>? items,
      String? name,
    }) {
      startDate ??= event?.startTimeJp?.toDateTime();
      items ??= event?.items ?? {};
      name ??= event?.localizedName ?? '';
      if (startDate == null) return;
      startDate = DateUtils.dateOnly(
          DateUtils.addDaysToDate(startDate, eventDateDelta));
      final detail = dataMap[startDate.toDateString()];
      if (detail == null) return;

      detail.addSQ += items[Items.quartz] ?? 0;
      detail.addTicket += items[Items.summonTicket] ?? 0;
      detail.addApple += (items[Items.goldApple] ?? 0) +
          (items[Items.silverApple] ?? 0) / 2 +
          (items[Items.bronzeApple] ?? 0) / 14.2;
      if (name.isNotEmpty) {
        detail.events.add(name);
      }
    }

    db.gameData.events.limitEvents.values.forEach((e) => _checkEvent(event: e));
    db.gameData.events.mainRecords.values.forEach((e) => _checkEvent(event: e));
    db.gameData.events.campaigns.values.forEach((e) => _checkEvent(event: e));
    // check master mission
    final extraMissionItems = sumDict(db.gameData.events.extraMasterMissions
        .where((e) => extraMissions[e.id] == true)
        .map((e) => e.itemRewards));
    _checkEvent(
      startDate: DateUtils.addDaysToDate(endDate, -eventDateDelta),
      items: extraMissionItems,
      name: 'Extra Mission',
    );

    solution = dataMap.values.toList();
    solution.sort((a, b) => a.date.compareTo(b.date));
    for (int index = 1; index < solution.length; index++) {
      final lastDate = solution[index - 1], curDate = solution[index];
      curDate
        ..accSQ = lastDate.accSQ + curDate.addSQ
        ..accTicket = lastDate.accTicket + curDate.addTicket
        ..accApple = lastDate.accApple + curDate.addApple;
    }
    return solution;
  }
}

class SQDayDetail {
  DateTime date;
  int accLogin;
  int continuousLogin;
  int addSQ;
  int accSQ;
  int addTicket;
  int accTicket;
  double addApple;
  double accApple;
  List<String> events;

  SQDayDetail({
    required this.date,
    this.accLogin = 0,
    int continuousLogin = 0,
    this.addSQ = 0,
    this.accSQ = 0,
    this.addTicket = 0,
    this.accTicket = 0,
    this.addApple = 0,
    this.accApple = 0,
    List<String>? events,
  })  : continuousLogin = fixValidRange(continuousLogin, 1, 7),
        events = events ?? [];

  SQDayDetail next({
    int addSQ = 0,
    int addTicket = 0,
    double addApple = 0,
    List<String>? events,
  }) {
    return SQDayDetail(
      date: DateUtils.addDaysToDate(date, 1),
      continuousLogin: continuousLogin + 1,
      addSQ: addSQ,
      accSQ: accSQ + addSQ,
      addTicket: addTicket,
      accTicket: accTicket + addTicket,
      addApple: addApple,
      accApple: accApple + addApple,
      events: events ?? [],
    );
  }
}
