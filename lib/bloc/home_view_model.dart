import 'package:todo_app_flutter/repository/home_contract.dart';
import 'package:todo_app_flutter/repository/item.dart';

class HomeViewModel implements ViewModel {
  final Model _model;
  final View _view;

  HomeViewModel(this._model, this._view);

  @override
  Future<int> insertItem(Item item) async {
    final insert = await _model.insertItem(item);
    viewDisplayed();
    return insert;
  }

  @override
  Future viewDisplayed() async{
    List<Item> items = await _model.getItems();
    _view.showItems(items);
  }

  @override
  Future<void> deleteItem(int id) async {
    _model.deleteItem(id);
    viewDisplayed();
  }

  @override
  toggleComplete(Item item) {
    item.isCompleted = !item.isCompleted;
    updateItem(item);
  }

  @override
  updateItem(Item item) {
    _model.updateItem(item);
    viewDisplayed();
  }

}