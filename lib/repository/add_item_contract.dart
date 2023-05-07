import 'package:flutter/material.dart';
import 'package:todo_app_flutter/repository/item.dart';

abstract class Model {
  saveItem(context, Item item);
  forfeitItem(context);
}

abstract class View {
  PreferredSizeWidget buildAppBar();
  Widget buildBody();
  InputBorder borderStyle();
  Widget taskNameField(String? hintText);
  Widget additionalTextField(Icon icon, String? hintText);
  saveItemHandler();
  forfeitItemHandler();
}

abstract class ViewModel {
  saveItem(context, int id, String title, String description);
  forfeitItem(context);
}