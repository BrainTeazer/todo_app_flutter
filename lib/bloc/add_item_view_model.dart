import 'package:todo_app_flutter/repository/add_item_contract.dart';
import 'package:todo_app_flutter/repository/item.dart';

class AddItemViewModel implements ViewModel {
  final Model _model;
  final View _view;

  AddItemViewModel(this._model, this._view);

  @override
  forfeitItem(context) {
    _model.forfeitItem(context);
  }

  @override
  saveItem(context, int id, String title, String description) {
    Item item = Item(id: id, title: title, description: description, isCompleted: false);
    _model.saveItem(context, item);
  }

}