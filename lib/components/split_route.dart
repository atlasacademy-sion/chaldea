///TODO: add transition animation and swipe support
import 'package:chaldea/modules/blank_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config.dart' show db;

const int kMasterRatio = 38; // percentage

bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width >=
      (db.userData?.criticalWidth ?? 768);
}

class SplitRoute<T> extends TransitionRoute<T> with LocalHistoryRoute<T> {
  final WidgetBuilder builder;
  final RouteSettings settings;
  bool tablet;
  FocusScopeNode node = FocusScopeNode();

  SplitRoute({@required this.builder, RouteSettings settings})
      : settings = settings ?? RouteSettings(),
        super(settings: settings ?? RouteSettings());

  ///if [builder] is null, just pop without push
  static Future popAndPush(BuildContext context,
      {WidgetBuilder builder, bool isDetail = true}) {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.of(context).popUntil((route) => route.settings.isInitialRoute);
    if (builder != null) {
      return Navigator.of(context).push(SplitRoute(
          builder: builder,
          settings: RouteSettings(isInitialRoute: !isDetail)));
    } else {
      return Future.value(null);
    }
  }

  static Future push(BuildContext context,
      {WidgetBuilder builder, bool isDetail = true}) {
    assert(builder != null);
    FocusScope.of(context).requestFocus(FocusNode());
    return Navigator.of(context).push(SplitRoute(
        builder: builder, settings: RouteSettings(isInitialRoute: !isDetail)));
  }

  static Widget createMasterPage(BuildContext context, Widget child) {
    if (!isTablet(context)) {
      return child;
    }
    return Row(
      children: <Widget>[
        Flexible(
            flex: kMasterRatio,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      right: Divider.createBorderSide(context, width: 0.2))),
              child: child,
            )),
        Flexible(flex: 100 - kMasterRatio, child: BlankPage()),
      ],
    );
  }

  // DetailPage should not be created outside SplitRoute()
  Widget createDetailPage(BuildContext context, Widget child) {
    final fullWidth = MediaQuery.of(context).size.width,
        masterWidth = fullWidth * kMasterRatio / 100,
        detailWidth = fullWidth - masterWidth;
    Widget detail = Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border(left: BorderSide(width: 0))),
      child: FocusScope(
        node: node,
        child: tablet
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                width: detailWidth,
                child: child,
              )
            : child,
      ),
    );
    return tablet ? Positioned(left: masterWidth, child: detail) : detail;
  }

  @override
  Iterable<OverlayEntry> createOverlayEntries() sync* {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    yield OverlayEntry(
        opaque: false,
        maintainState: true,
        builder: (context) {
          tablet = isTablet(context);
          return settings.isInitialRoute
              ? createMasterPage(context, builder(context))
              : createDetailPage(context, builder(context));
        });
  }

  @override
  bool didPop(T result) {
    final bool returnValue = super.didPop(result);
    assert(returnValue);
    if (finishedWhenPopped) {
      navigator.finalizeRoute(this);
    }
    return returnValue;
  }

  /// TODO: enhance? set opaque=false when tablet=false **dynamic**,
  /// but this getter is called only once. thus the error is:
  /// when portrait to landscape, detail-page is still opaque(black master part)
  @override
  bool get opaque => settings.isInitialRoute == true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 250);
}

class SplitViewBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackButton(
      onPressed: () async {
        await SplitRoute.popAndPush(context);
        Navigator.maybePop(context);
      },
    );
  }
}
