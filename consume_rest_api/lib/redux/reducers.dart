import '../models/item.dart';
import '../models/app_state.dart';
import '../redux/actions.dart';

import 'package:redux/redux.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(items: itemReducer(state.items, action));
}

Reducer<List<Item>> itemReducer = combineReducers<List<Item>>([
  TypedReducer<List<Item>, AddItemAction>(addItemReducer),
  TypedReducer<List<Item>, RemoveItemAction>(removeItemReducer),
  TypedReducer<List<Item>, RemoveItemsAction>(removeItemsReducer),
  TypedReducer<List<Item>, LoadedItemsAction>(loadedItemsReducer),
  TypedReducer<List<Item>, ItemCompletedAction>(itemCompletedReducer),
]);

List<Item> addItemReducer(List<Item> state, action) {
  return []
      ..addAll(state)
      ..add(Item(id: action.id, body: action.item));
}

List<Item> removeItemReducer(List<Item> state, action) {
  return List.unmodifiable(List.from(state)..remove(action.item));
}

List<Item> removeItemsReducer(List<Item> state, action) {
  return List.unmodifiable([]);
}

List<Item> loadedItemsReducer(List<Item> state, action) {
  return action.items;
}

List<Item> itemCompletedReducer(List<Item> state, action) {
  return state.map((Item item) => item.id == action.item.id
          ? item.copyWith(completed: !item.completed)
          : item).toList();
}