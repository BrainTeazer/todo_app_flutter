import 'package:flutter/material.dart';
import 'package:todo_app_flutter/repository/home_contract.dart';
import 'package:todo_app_flutter/screens/home/home_model.dart';
import 'package:todo_app_flutter/bloc/home_view_model.dart';
import 'package:todo_app_flutter/repository/item.dart';
import 'dart:async';

import 'package:todo_app_flutter/repository/sql/sql_todo_repo.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements View {
  List<Item> _items = [];
  ViewModel? _viewModel;
  SQLRepo db = SQLRepo();

  //
  //
  // Future<Widget> _sortTodoHandler() async {
  //   List<String> radioOptions = ['id', 'title'];
  //   String? selectedRadio = radioOptions[0];
  //
  //   return SimpleDialog(
  //     title: const Text("wow"),
  //     children: [
  //       Radio(
  //           value: radioOptions[0],
  //           groupValue: selectedRadio,
  //           onChanged:( (val) => selectedRadio = val )
  //   ),
  //     Radio(
  //     value: radioOptions[1],
  //     groupValue: selectedRadio,
  //     onChanged:( (val) => selectedRadio = val )
  //     ),
  //
  //       TextButton(
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //           _viewModel?.viewDisplayed();
  //         },
  //         child: Text("submit"),
  //       )
  //     ],
  //   );
  //
  //
  // }
  Future<void> _deleteTodoHandler(int id) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete item'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Are you sure want to delete the item?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(child: const Text('No'), onPressed: () {
                Navigator.of(context).pop();
              }),
              TextButton(child: const Text('Yes'), onPressed: () {
                _viewModel?.deleteItem(id);
                Navigator.of(context).pop();
              })
            ],
          );
        }
    );
  }

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(HomeModel(), this);
    _viewModel?.viewDisplayed();
  }

  @override
  PreferredSizeWidget buildAppBar()  {
    return AppBar(
      title: const Text("My Tasks"),
      backgroundColor: Colors.black.withAlpha(200),
    );
  }

  @override
  Widget buildBottomAppBar() {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        // type: BottomNavigationBarType.fixed,
        child: Row (
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: const Icon(Icons.menu), onPressed: (){}),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget> [
                  IconButton(icon: const Icon(Icons.sort), onPressed: (){}),
                  IconButton(icon: const Icon(Icons.more_vert), onPressed: (){})
                ]
            ),
          ],
        )

    );
  }

  @override
  addItemHandler() async {
    final itemAdd = await Navigator.pushNamed(
      context,
      '/addItem',
    );

    if (itemAdd != false) {
      _viewModel?.insertItem(itemAdd as Item);
    }
  }

  Widget _buildList() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: _items.map((Item item) {
        return _buildListRow(item);
      }).toList(),
    );
  }

  Widget _buildListRow(item) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Checkbox(
              value: item.isCompleted,
              side: const BorderSide(color: Colors.blue),
              activeColor: Colors.blue,
              //checkColor: Colors.black,
              onChanged: (bool? value) {
                setState(() {
                  _viewModel?.toggleComplete(item);
                });
              }),
          Expanded(
              child: Text(
                  item.title,
                      style: TextStyle(
                        fontSize: 18,
                        color:  item.isCompleted ? Colors.grey : (Theme.of(context).textTheme.bodySmall?.color ?? Colors.white),
                        fontWeight: FontWeight.w300,
                          decoration: item.isCompleted ? TextDecoration.lineThrough :TextDecoration.none
                      )
              )
          ),
          Row(
            children: [
              IconButton(icon: const Icon(Icons.delete), onPressed: () {
                _deleteTodoHandler(item.id);
              }, color: item.isCompleted ? Colors.grey : Colors.white,)
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addItemHandler(),
        child: const Icon(Icons.add),
      ),

      body: _buildList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: buildBottomAppBar(),
    );
  }


  @override
  showItems(List<Item> items) {
      setState(() {
        _items = items;
      });
  }

  @override
  void dispose() {
    super.dispose();
    db.closeRepository();
  }
}