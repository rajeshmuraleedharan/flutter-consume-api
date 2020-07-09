import 'package:consume_rest_api/redux/actions.dart';
import 'package:consume_rest_api/screens/home/home.dart';
import 'package:consume_rest_api/service_locator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

import 'models/app_state.dart';
import 'redux/reducers.dart';
import 'redux/middleware.dart';

void main() {
  ServiceLocator.setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DevToolsStore<AppState> store = DevToolsStore<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
        middleware: appStateMiddleware());

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData.dark(),
        home: StoreBuilder<AppState>(
          onInit: (store) => store.dispatch(GetItemsAction()),
          builder: (BuildContext context, Store<AppState> store) =>
              MyHomePage(store),
        ),
      ),
    );
  }
}
