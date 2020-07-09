import 'package:consume_rest_api/redux/actions.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';
import 'item.dart';

class ItemViewModel {
  final List<Item> items;
  final Function(String) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;
  final Function(Item) onItemCompletedAction;

  ItemViewModel(
      {this.items,
      this.onAddItem,
      this.onRemoveItem,
      this.onRemoveItems,
      this.onItemCompletedAction});

  factory ItemViewModel.create(Store<AppState> store) {
    _onAddItem(String body) => store.dispatch(AddItemAction(body));

    _onRemoveItem(Item item) => store.dispatch(RemoveItemAction(item));

    _onRemoveItems() => store.dispatch(RemoveItemsAction());

    _onItemCompletedAction(Item item) =>
        store.dispatch(ItemCompletedAction(item));

    return ItemViewModel(
        items: store.state.items,
        onAddItem: _onAddItem,
        onRemoveItem: _onRemoveItem,
        onRemoveItems: _onRemoveItems,
        onItemCompletedAction: _onItemCompletedAction);
  }
}
