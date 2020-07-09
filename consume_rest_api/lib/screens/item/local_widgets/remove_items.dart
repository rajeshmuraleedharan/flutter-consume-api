import 'package:consume_rest_api/models/item_view_model.dart';
import 'package:flutter/material.dart';


class RemoveItemsButtonWidget extends StatelessWidget{
  final ItemViewModel model;

  RemoveItemsButtonWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Delete all Items"),
      onPressed: (){
        model.onRemoveItems();
      },
    );
  }
}