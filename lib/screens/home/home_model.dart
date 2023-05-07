import 'package:todo_app_flutter/repository/home_contract.dart';
import 'package:todo_app_flutter/repository/item.dart';
import 'package:todo_app_flutter/repository/sql/sql_todo_repo.dart';

class HomeModel implements Model {
  @override
  Future<List<Item>> getItems() async{
    final database = SQLRepo();
    await database.initRepository(SQLRepo.databasePath);
    List<Item> items = await database.retrieveAllItems();
    await database.closeRepository();
    return items;
  }

  @override
  Future<int> insertItem(Item item) async {
    final database = SQLRepo();
    await database.initRepository(SQLRepo.databasePath);
    final insert = await database.insertItem(item);
    await database.closeRepository();
    return insert;
  }

  @override
  Future<void> deleteItem(int id) async {
    final database = SQLRepo();
    await database.initRepository(SQLRepo.databasePath);
    await database.deleteItem(id);
    await database.closeRepository();
  }

  @override
  updateItem(Item item) async {
    final database = SQLRepo();
    await database.initRepository(SQLRepo.databasePath);
    await database.updateItem(item);
    await database.closeRepository();
  }


}