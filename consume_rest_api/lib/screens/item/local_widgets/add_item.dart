import 'package:consume_rest_api/models/item_view_model.dart';
import 'package:flutter/material.dart';


class AddItemWidget extends StatefulWidget {
  final ItemViewModel model;

  AddItemWidget(this.model);

  @override
  State<StatefulWidget> createState() => _AddItemState();
}

class _AddItemState extends State<AddItemWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: "add an item"),
      onSubmitted: (String s) {
        widget.model.onAddItem(s);
        controller.text = "";
      },
    );
  }
}
