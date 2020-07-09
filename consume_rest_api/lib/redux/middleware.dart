import 'package:consume_rest_api/models/item.dart';
import 'package:consume_rest_api/services/items_Service.dart';
import 'package:redux/redux.dart';

import '../service_locator.dart';
import '../utils/manage_prefs.dart';

import '../models/app_state.dart';
import '../redux/actions.dart';

List<Middleware<AppState>> appStateMiddleware(
    [AppState state = const AppState(items: [])]) {
  final loadFromPrefs = _loadFromPrefs(state);
  final saveToPrefs = _saveToPrefs(state);
  final saveToApi = _saveToApi(state);

  return [
    TypedMiddleware<AppState, AddItemAction>(saveToApi),
    TypedMiddleware<AppState, RemoveItemAction>(saveToPrefs),
    TypedMiddleware<AppState, RemoveItemsAction>(saveToPrefs),
    TypedMiddleware<AppState, ItemCompletedAction>(saveToPrefs),
    TypedMiddleware<AppState, GetItemsAction>(loadFromPrefs),
  ];
}

Middleware<AppState> _loadFromPrefs(AppState state) {
  final _itemService = ServiceLocator.getService<ItemsService>();

  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    _fetchItems(store);
  };
}

Middleware<AppState> _saveToApi(AppState state) {
  final _itemService = ServiceLocator.getService<ItemsService>();

  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    if (action is AddItemAction) {
      _itemService
          .addItem(Item(body: action.item, completed: false, id: 0))
          .then((value) => _fetchItems(store));
    }
  };
}

Middleware<AppState> _saveToPrefs(AppState state) {
  //final _itemService = ServiceLocator.getService<ItemsService>();

  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    ManagePrefsUtil.saveToPrefs(store.state);
  };
}

void _fetchItems(Store<AppState> store) {
  final _itemService = ServiceLocator.getService<ItemsService>();
  _itemService.getItemsList().then((items) => {
        if (items.data != null) {store.dispatch(LoadedItemsAction(items.data))}
      });
}
