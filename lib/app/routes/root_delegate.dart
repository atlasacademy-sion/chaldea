import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../modules/root/window_manager.dart';
import 'delegate.dart';
import 'routes.dart';

class AppState extends ChangeNotifier {
  final RootAppRouterDelegate _root;
  late final List<AppRouterDelegate> _children;

  AppState(this._root) {
    addListener(_root.notifyListeners);
    _children = [AppRouterDelegate(_root)];
  }

  /// windows(routers)
  List<AppRouterDelegate> get children => List.unmodifiable(_children);

  int get activeIndex => _activeIndex;
  int _activeIndex = 0;

  AppRouterDelegate get activeRouter => _children[_activeIndex];

  set activeIndex(int index) {
    if (index >= 0 && index < _children.length) {
      _activeIndex = index;
      notifyListeners();
    }
  }

  int addWindow() {
    _children.add(AppRouterDelegate(_root));
    _activeIndex = _children.length - 1;
    notifyListeners();
    return _activeIndex;
  }

  int removeWindow(int index) {
    assert(index >= 0 && index < _children.length);
    if (index < 0 || index >= _children.length) {
      return -1;
    }
    if (_children.length == 1) return -1;
    final active = activeRouter;
    _children.removeAt(index);
    int newIndex = _children.indexOf(active);
    _activeIndex = newIndex >= 0 ? newIndex : 0;
    notifyListeners();
    return _activeIndex;
  }

  /// _showWindowManager
  bool get showWindowManager => _showWindowManager;
  bool _showWindowManager = false;

  set showWindowManager(bool v) {
    _showWindowManager = v;
    notifyListeners();
  }

  /// _showSidebar
  bool get showSidebar => _showSidebar;
  bool _showSidebar = true;

  set showSidebar(bool v) {
    _showSidebar = v;
    notifyListeners();
  }

  /// _dataReady
  bool get dataReady => _dataReady;
  bool _dataReady = false;

  set dataReady(bool v) {
    _dataReady = v;
    notifyListeners();
  }
}

class RootAppRouterDelegate extends RouterDelegate<RouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration> {
  late final AppState appState;

  RootAppRouterDelegate() {
    appState = AppState(this);
  }

  @override
  RouteConfiguration? get currentConfiguration =>
      appState.activeRouter.currentConfiguration;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(child: WindowManager(delegate: this)),
      ],
      onPopPage: (route, result) {
        if (appState.showWindowManager) {
          if (!route.didPop(result)) return false;
          appState.showWindowManager = false;
          return true;
        }
        return appState.activeRouter.onPopPage(route, result);
      },
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => kAppKey;

  @override
  Future<void> setInitialRoutePath(RouteConfiguration configuration) {
    // TODO: do init and gamedata check
    return super.setInitialRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) {
    return appState.activeRouter.setNewRoutePath(configuration);
  }

  @override
  Future<bool> popRoute() {
    return appState.activeRouter.popRoute();
  }
}
