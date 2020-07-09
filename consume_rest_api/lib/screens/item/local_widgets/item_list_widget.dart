import 'package:consume_rest_api/models/item.dart';
import 'package:consume_rest_api/models/item_view_model.dart';
import 'package:flutter/material.dart';


class ItemListWidget extends StatefulWidget {
  final ItemViewModel model;

  ItemListWidget(this.model);

  @override
  State<StatefulWidget> createState() => _ItemListState();
}

class _ItemListState extends State<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.model.items.map((Item item) => ListTile(
        title: Text(item.body),
        leading: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => widget.model.onRemoveItem(item),
        ),
        trailing: Checkbox(
          value: item.completed,
          onChanged: (b) => widget.model.onItemCompletedAction(item),
        ),
      )).toList(),
    );
  }
}