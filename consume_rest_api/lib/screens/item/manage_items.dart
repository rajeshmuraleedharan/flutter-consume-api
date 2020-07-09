import 'package:consume_rest_api/models/item_view_model.dart';
import 'package:flutter/cupertino.dart';

import 'local_widgets/add_item.dart';
import 'local_widgets/item_list_widget.dart';
import 'local_widgets/remove_items.dart';

class ManageItemsWidget extends StatelessWidget {
  final ItemViewModel viewModel;

  ManageItemsWidget(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddItemWidget(viewModel),
        Expanded(
          child: ItemListWidget(viewModel),
        ),
        RemoveItemsButtonWidget(viewModel),
      ],
    );
  }
}
