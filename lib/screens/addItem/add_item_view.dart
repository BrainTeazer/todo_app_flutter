import 'package:flutter/material.dart';
import 'package:todo_app_flutter/repository/add_item_contract.dart';
import 'package:todo_app_flutter/screens/addItem/add_item_model.dart';
import 'package:todo_app_flutter/bloc/add_item_view_model.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  _AddItemPagePageState createState() => _AddItemPagePageState();
}

class _AddItemPagePageState extends State<AddItemPage> implements View {

  final taskNameController = TextEditingController();
  final descriptionController = TextEditingController();
  ViewModel? _viewModel;
  bool _validate = false;


  @override
  void initState() {
    super.initState();
    _viewModel = AddItemViewModel(AddItemModel(), this);
  }

  @override
  PreferredSizeWidget buildAppBar()  {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon: const Icon(Icons.save), onPressed: () => saveItemHandler()),
          IconButton(icon: const Icon(Icons.delete_forever_rounded), onPressed: () => forfeitItemHandler())
        ],
      )

    );
  }

  @override
  saveItemHandler() {
    int id = DateTime.now().millisecondsSinceEpoch;
    String title = taskNameController.text;
    String? description = descriptionController.text;

    if (title.trim() != "") {
      _validate = false;
      _viewModel?.saveItem(context, id, title, description);
    } else {
      setState(() {
        _validate = true;
      });
    }

  }

  @override
  forfeitItemHandler() {
    _viewModel?.forfeitItem(context);
  }

  @override
  Widget taskNameField(String? hintText) {
    double textFontSize = 28.0;

    return TextFormField(
        controller: taskNameController,
        cursorColor: Colors.red,
        cursorHeight: textFontSize * 1.45,
        decoration: InputDecoration(
          border: InputBorder.none,
          errorText: _validate ? "Please provide a task name." : null,
          hintText: hintText,
          contentPadding: const EdgeInsets.all(20.0),
          focusedBorder: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: textFontSize,
          fontWeight: FontWeight.w600,
          height: 1.3
        ),
      onChanged: (val) {
        if (val.length == 1) {
          setState(() {
            _validate = false;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    taskNameController.dispose();
    super.dispose();
  }
  @override
  InputBorder borderStyle() {
    return UnderlineInputBorder(
        borderSide:  BorderSide(color: ThemeData().colorScheme.surface),
        borderRadius: BorderRadius.zero,
    );
  }
  
  @override
  Widget additionalTextField(Icon icon, String? hintText) {
    double textFontSize = 20.0;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Flexible(
            child: TextFormField(
                controller: descriptionController,
                cursorColor: Colors.red,
                cursorHeight: textFontSize * 1.45,
                decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding: const EdgeInsets.all(20.0),
                  prefixIcon: icon,
                  border: borderStyle(),
                  enabledBorder: borderStyle(),
                  focusedBorder: borderStyle()
                ),
                style: TextStyle(
                    fontSize: textFontSize,
                    height: 1.3
                ),

            )
        )],
    );
  }

  @override
  Widget buildBody() {
    return Column(
      children: [
        taskNameField("Task name"),
        additionalTextField(const Icon(Icons.description_outlined), "Description")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody()
    );
  }
}
