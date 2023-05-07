import 'package:path/path.dart';
import 'package:todo_app_flutter/repository/item.dart';
import 'package:todo_app_flutter/repository/todo_repo.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';


class SQLRepo extends TodoRepo {
  static const String databasePath = 'todo_repository.db';
  static const String tableName = 'todo';


  late Database _db;

  @override
  Future<void> initRepository(path) async {
    WidgetsFlutterBinding.ensureInitialized();
    String dbPath = await getDatabasesPath();
    _db =  await openDatabase(
      join(dbPath, path),
      onCreate: (db, version) => db.execute(createRepositoryQuery()),version: 1,
    );
  }



  @override
  String createRepositoryQuery() {
    return 'CREATE TABLE todo(id INTEGER PRIMARY KEY, title STRING, description STRING, isCompleted BIT)';
  }

  @override
  Future<void> deleteItem(int id) async {
    await _db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id]
    );
  }

  @override
  Future<int> insertItem(Item item) async {
    return await _db.insert(
        tableName,
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  @override
  Future<List<Item>> retrieveAllItems() async {


    // Query the table for all The Items.
    final List<Map<String, dynamic>> maps = await _db.query(tableName);

    // Convert the List<Map<String, dynamic> into a List<Item>.
    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        isCompleted: maps[i]['isCompleted'] == 1 ? true : false,
      );
    });
  }

  @override
  Future<void> updateItem(Item item) async {
    _db.update(
        tableName,
        item.toMap(),
        where: 'id = ?',
        whereArgs: [item.id]
    );
  }

  @override
  closeRepository() async {
    await _db.close();
  }

}