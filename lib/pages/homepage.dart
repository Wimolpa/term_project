import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/helpers/api_caller.dart';
import 'package:term_project/helpers/dialog_utils.dart';
import 'package:term_project/helpers/my_text_fild.dart';
import 'package:term_project/models/additem_models.dart';
import 'package:term_project/models/todo_items.dart';
import 'package:term_project/pages/additem.dart';
import 'package:term_project/pages/reviewpage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _titleTextController = TextEditingController();
  ProductsList _todoItems = ProductsList();
  List<additem> _additem = [];
  bool _isLoading = true;
  bool _isLoading1 = true;
  @override
  void initState() {
    super.initState();
    _loadTodoItems();
    // _getItem();
    // _loadTodoItems1();
  }

  Future<void> _loadTodoItems() async {
    try {
      final data = await ApiCaller().get("https://dummyjson.com/products");
      // ข้อมูลที่ได้จาก API นี้จะเป็น JSON array ดังนั้นต้องใช้ List รับค่าจาก jsonDecode()
      // List list = jsonDecode(data);
      setState(() {
        _todoItems = ProductsList.fromJson(jsonDecode(data));
        // _isLoading = false;
      });

      _getItem();
    } on Exception catch (e) {
      showOkDialog(context: context, title: "Error", message: e.toString());
    }
  }

  Future<void> _loadTodoItems1() async {
    try {
      final data = await ApiCaller().get("http://localhost:3000/product");
      // print(data);
      // ข้อมูลที่ได้จาก API นี้จะเป็น JSON array ดังนั้นต้องใช้ List รับค่าจาก jsonDecode()
      List list = jsonDecode(data);
      print('done2');
      print('done2');
      setState(() {
        _additem = list.map((e) => additem.fromJson(e)).toList();
        _isLoading = false;
        print('done3');
      });
    } on Exception catch (e) {
      showOkDialog(context: context, title: "Error", message: e.toString());
    }
  }

  Future<void> _getItem() async {
    for (int i = 1; i < _todoItems.products!.length; i++) {
      print(_todoItems.products!.length);
      final item = _todoItems.products![i];
      if (item.category == 'skincare') {
        var caller = ApiCaller();
        var data = await caller.post(
          'product',
          params: {
            "itemname": item.title!,
            "price": item.price!,
            "image": item.images![0].toString(),
            "description": item.description!,
          },
        );
      }
    }
    print('done1');
    _loadTodoItems1();
  }

  @override
  Widget build(BuildContext context) {
    // var textTheme = Theme.of(context).textTheme;
    // _getItem();
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
          title: const Text('รายการสินค้า'), backgroundColor: Colors.blue[200]),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyTextField(
                    controller: _titleTextController,
                    hintText: 'ชื่อสินค้า*',
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _additem.length,
                      itemBuilder: (context, index) {
                        final item = _additem[index];
                        // debugPrint(_todoItems.products!.length.toString());
                        //debugPrint(item.itemname!.toString());
                        return Card(
                          child: ListTile(
                            title: Text(item.itemname!,
                                style: GoogleFonts.poppins()),
                            subtitle: Text('ราคา: ${item.price!} USD',
                                style: GoogleFonts.poppins()),
                            trailing: Image.network(
                              item.image!.toString(),
                              width: 40,
                              height: 40,
                            ),
                            onTap: () {
                              print(item.itemname);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ReviewpPage1(
                                      item.itemname!,
                                      item.price!,
                                      item.description!,
                                      item.image!,
                                      item.pid,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Additem();
                      }));
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Text('เพิ่มสินค้า',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue[700])),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
