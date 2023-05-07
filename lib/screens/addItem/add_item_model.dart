import 'package:flutter/widgets.dart';
import 'package:todo_app_flutter/repository/add_item_contract.dart';
import 'package:todo_app_flutter/repository/item.dart';

class AddItemModel implements Model {
  @override
  forfeitItem(context) {
    Navigator.pop(context, false);
  }

  @override
  saveItem(context, Item item) {
    Navigator.pop(context, item);
  }

}