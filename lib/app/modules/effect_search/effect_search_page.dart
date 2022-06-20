import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:chaldea/app/modules/common/builders.dart';
import 'package:chaldea/app/modules/common/filter_page_base.dart';
import 'package:chaldea/generated/l10n.dart';
import 'package:chaldea/models/models.dart';
import 'package:chaldea/packages/split_route/split_route.dart';
import 'package:chaldea/utils/utils.dart';
import 'package:chaldea/widgets/widgets.dart';
import 'filter.dart';

enum _CardType {
  svt,
  ce,
  cc,
}

class EffectSearchPage extends StatefulWidget {
  EffectSearchPage({Key? key}) : super(key: key);

  @override
  _EffectSearchPageState createState() => _EffectSearchPageState();
}

class _EffectSearchPageState extends State<EffectSearchPage>
    with
        SearchableListState<GameCardMixin, EffectSearchPage>,
        SingleTickerProviderStateMixin {
  late TabController _tabController;
  final filterData = BuffFuncFilterData();

  @override
  Iterable<GameCardMixin> get wholeData {
    if (_tabController.index == 0) {
      return db.gameData.servants.values;
    } else if (_tabController.index == 1) {
      return db.gameData.craftEssences.values;
    } else {
      return db.gameData.commandCodes.values;
    }
  }

  @override
  void initState() {
    super.initState();
    options = _BuffOptions(onChanged: (_) {
      if (mounted) setState(() {});
    });
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        (options as _BuffOptions).type =
            _CardType.values.getOrNull(_tabController.index) ?? _CardType.svt;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    filterShownList();
    return scrollListener(
      useGrid: filterData.useGrid,
      appBar: AppBar(
        leading: const MasterBackButton(),
        titleSpacing: 0,
        title: Text(S.current.effect_search),
        actions: [
          SharedBuilder.docsHelpBtn('buff_filter.html'),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            tooltip: S.of(context).filter,
            onPressed: () => FilterPage.show(
              context: context,
              builder: (context) => BuffFuncFilter(
                filterData: filterData,
                onChanged: (_) {
                  if (mounted) setState(() {});
                },
              ),
            ),
          ),
          searchIcon,
        ],
        bottom: showSearchBar ? searchBar : tabBar,
      ),
    );
  }

  TabBar get tabBar => TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: S.current.servant),
          Tab(text: S.current.craft_essence),
          Tab(text: S.current.command_code),
        ],
      );

  @override
  bool filter(GameCardMixin card) {
    List<NiceFunction> functions = [];
    if (card is Servant) {
      bool _isScopeEmpty = filterData.effectScope.options.isEmpty;
      functions = [
        if (_isScopeEmpty ||
            filterData.effectScope.options.contains(SvtEffectScope.active))
          for (final skill in card.skills)
            ...skill.filteredFunction(includeTrigger: true),
        if (_isScopeEmpty ||
            filterData.effectScope.options.contains(SvtEffectScope.td))
          for (final np in card.noblePhantasms)
            ...np.filteredFunction(includeTrigger: true),
        if (_isScopeEmpty ||
            filterData.effectScope.options.contains(SvtEffectScope.append))
          for (final skill in card.appendPassive)
            ...skill.skill.filteredFunction(includeTrigger: true),
        if (_isScopeEmpty ||
            filterData.effectScope.options.contains(SvtEffectScope.passive))
          for (final skill in card.classPassive)
            ...skill.filteredFunction(includeTrigger: true),
      ];
    } else if (card is CraftEssence) {
      functions = [
        for (final skill in card.skills) ...skill.functions,
      ];
    } else if (card is CommandCode) {
      functions = [
        for (final skill in card.skills) ...skill.functions,
      ];
    }
    functions.retainWhere(
        (func) => filterData.effectTarget.matchOne(func.funcTargetType));
    Set<FuncType> funcTypes = {
      for (final func in functions) func.funcType,
    };
    Set<BuffType> buffTypes = {
      for (final func in functions)
        for (final buff in func.buffs) buff.type,
    };
    if (!FilterGroupData<dynamic>(
        matchAll: filterData.funcAndBuff.matchAll,
        invert: filterData.funcAndBuff.invert,
        options: {
          ...filterData.funcType.options,
          ...filterData.buffType.options,
        }).matchAny({...funcTypes, ...buffTypes})) {
      return false;
    }
    return true;
  }

  @override
  Widget gridItemBuilder(GameCardMixin card) {
    return card.iconBuilder(
      context: context,
      padding: const EdgeInsets.all(2),
      jumpToDetail: true,
    );
  }

  @override
  Widget listItemBuilder(GameCardMixin card) {
    return ListTile(
      leading: card.iconBuilder(context: context, height: 48),
      visualDensity: VisualDensity.compact,
      title: AutoSizeText(
        card.lName.l,
        maxLines: 2,
        maxFontSize: 14,
        minFontSize: 8,
      ),
      subtitle: Text('No.${card.collectionNo}'),
      onTap: () {
        card.routeTo();
      },
    );
  }
}

class _BuffOptions with SearchOptionsMixin<GameCardMixin> {
  bool svtActiveSkill = true;
  bool svtNoblePhantasm = true;
  bool svtClassPassive = false;
  bool svtAppendSkill = false;
  _CardType type = _CardType.svt;
  @override
  ValueChanged? onChanged;

  _BuffOptions({this.onChanged});

  @override
  Widget builder(BuildContext context, StateSetter setState) {
    return Wrap(
      children: [
        CheckboxWithLabel(
          value: svtActiveSkill,
          label: Text(S.current.active_skill),
          onChanged: (v) {
            svtActiveSkill = v ?? svtActiveSkill;
            setState(() {});
            updateParent();
          },
        ),
        CheckboxWithLabel(
          value: svtNoblePhantasm,
          label: Text(S.current.noble_phantasm),
          onChanged: (v) {
            svtNoblePhantasm = v ?? svtNoblePhantasm;
            setState(() {});
            updateParent();
          },
        ),
        CheckboxWithLabel(
          value: svtClassPassive,
          label: Text(S.current.passive_skill),
          onChanged: (v) {
            svtClassPassive = v ?? svtClassPassive;
            setState(() {});
            updateParent();
          },
        ),
      ],
    );
  }

  @override
  Iterable<String?> getSummary(GameCardMixin card) sync* {
    if (type == _CardType.svt && card is Servant) {
      if (svtActiveSkill) {
        for (final skill in card.skills) {
          yield* getSkillKeys(skill);
        }
      }
      if (svtNoblePhantasm) {
        for (final skill in card.noblePhantasms) {
          yield* getSkillKeys(skill);
        }
      }
      if (svtClassPassive) {
        for (final skill in card.classPassive) {
          yield* getSkillKeys(skill);
        }
      }
      if (svtAppendSkill) {
        for (final skill in card.appendPassive) {
          yield* getSkillKeys(skill.skill);
        }
      }
    } else if (type == _CardType.ce && card is CraftEssence) {
      for (final skill in card.skills) {
        yield* getSkillKeys(skill);
      }
    } else if (type == _CardType.cc && card is CommandCode) {
      for (final skill in card.skills) {
        yield* getSkillKeys(skill);
      }
    }
  }
}