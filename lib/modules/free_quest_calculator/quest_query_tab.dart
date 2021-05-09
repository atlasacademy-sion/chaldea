import 'package:auto_size_text/auto_size_text.dart';
import 'package:chaldea/components/components.dart';
import 'package:chaldea/modules/shared/quest_card.dart';
import 'package:flutter_picker/flutter_picker.dart';

class FreeQuestQueryTab extends StatefulWidget {
  @override
  _FreeQuestQueryTabState createState() => _FreeQuestQueryTabState();
}

class _FreeQuestQueryTabState extends State<FreeQuestQueryTab> {
  late ScrollController _scrollController;
  List<PickerItem<String>> pickerData = [];
  String? chapter;
  String? questKey;
  Map<String, List<String>> _categorizedData = {};

  @override
  void initState() {
    _scrollController = ScrollController();
    db.gameData.freeQuests.forEach((key, quest) {
      _categorizedData.putIfAbsent(quest.chapter, () => <String>[]).add(key);
    });
    super.initState();
  }

  void setPickerData() {
    _categorizedData.forEach((chapter, quests) {
      pickerData.add(PickerItem<String>(
          text: Center(
            child: AutoSizeText(
              Quest.shortChapterOf(chapter),
              maxFontSize: 15,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color),
            ),
          ),
          value: chapter,
          children: quests.map((questKey) {
            final quest = db.gameData.freeQuests[questKey]!;
            return PickerItem<String>(
              text: Center(
                child: AutoSizeText(
                  quest.localizedKey,
                  maxFontSize: 15,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color),
                ),
              ),
              value: quest.indexKey,
            );
          }).toList()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      children: [
        questPicker,
        questKey == null || !db.gameData.freeQuests.containsKey(questKey)
            ? Center()
            : QuestCard(quest: db.gameData.freeQuests[questKey]!),
      ],
    );
  }

  Widget get questPicker {
    if (pickerData.isEmpty) setPickerData();
    return Center(
      child: TextButton(
        onPressed: () {
          Picker(
            adapter: PickerDataAdapter<String>(data: pickerData),
            selecteds: chapter == null || questKey == null
                ? null
                : [
                    _categorizedData.keys.toList().indexOf(chapter!),
                    _categorizedData[chapter]!.indexOf(questKey!)
                  ],
            changeToFirst: true,
            hideHeader: true,
            textScaleFactor: 0.7,
            height: min(200, MediaQuery.of(context).size.height - 200),
            itemExtent: 48,
            backgroundColor: null,
            cancelText: S.of(context).cancel,
            confirmText: S.of(context).confirm,
            onConfirm: (Picker picker, List<int> intValues) {
              final stringValues = picker.getSelectedValues();
              setState(() {
                chapter = stringValues[0];
                questKey = stringValues[1];
              });
            },
          ).showDialog(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Text(
            chapter == null || questKey == null
                ? S.of(context).choose_quest_hint
                : '${Localized.chapter.of(chapter!)} / ${db.gameData.freeQuests[questKey]?.localizedKey}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
