import 'package:todo_app_flutter/repository/item.dart';

abstract class TodoRepo {
  Future<void> initRepository(path);
  String createRepositoryQuery();
  Future<int> insertItem(Item item);
  Future<List<Item>> retrieveAllItems();
  Future<void> deleteItem(int id);
  Future<void> updateItem(Item item);
  closeRepository();
}

