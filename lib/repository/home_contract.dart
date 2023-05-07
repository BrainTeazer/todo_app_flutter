import 'package:flutter/material.dart';
import 'package:todo_app_flutter/repository/item.dart';

abstract class Model {
  Future<List<Item>> getItems();
  Future<int> insertItem(Item item);
  Future<void> deleteItem(int id);
  updateItem(Item item);

}

abstract class View {
  PreferredSizeWidget buildAppBar();
  Widget buildBottomAppBar();
  addItemHandler();
  // Widget buildBody();
  showItems(List<Item> items);
}

abstract class ViewModel {
  Future<int> insertItem(Item item);
  Future<void> deleteItem(int id);
  Future viewDisplayed();
  updateItem(Item item);
  toggleComplete(Item item);
}
