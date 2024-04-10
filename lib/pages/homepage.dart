import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/helpers/api_caller.dart';
import 'package:term_project/helpers/dialog_utils.dart';
import 'package:term_project/helpers/my_text_fild.dart';
import 'package:term_project/models/additem_models.dart';
import 'package:term_project/models/todo_items.dart';
import 'package:term_project/pages/additem.dart';
import 'package:term_project/pages/loginpage.dart';
import 'package:term_project/pages/reviewpage.dart';

import '../helpers/storage.dart';

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
  bool _isLogin = true;
  @override
  void initState() {
    super.initState();
    _loadTodoItems();
    checkLogin();
    // _getItem();
    // _loadTodoItems1();
  }

  Future<void> checkLogin() async {
    var token = await Storage().read(Storage.keyToken);
    var id = await Storage().read(Storage.keyId);
    print("TEST" + token.toString());
    setState(() {
      if (token == null) {
        _isLogin = true;
      } else {
        _isLogin = false;
      }
    });
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
      // print('done2');
      // print('done2');
      setState(() {
        _additem = list.map((e) => additem.fromJson(e)).toList();
        _isLoading = false;
        // print('done3');
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
    // print('done1');
    _loadTodoItems1();
  }

  Future<void> deleteAll() async {
    await Storage().deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    // var textTheme = Theme.of(context).textTheme;
    // _getItem();
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
          title: const Text('รายการสินค้า'),
          backgroundColor: Colors.blue[200],
          actions: [
            _isLogin
                ? Container()
                : IconButton(
                    onPressed: () {
                      setState(() {
                        deleteAll();
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    icon: Icon(Icons.logout)),
            
          ]),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFf5f5f5),
                            prefixIcon: Icon(Icons.search),
                            contentPadding: const EdgeInsets.only(
                              left: 16.0,
                              bottom: 12.0,
                              top: 12.0,
                            ),
                            hintText: 'ชื่อสินค้า*',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                          onChanged: searchList,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Additem();
                            }));
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'add',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.grey[800], fontSize: 13.0),
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            fixedSize: MaterialStateProperty.all<Size>(
                              const Size(100, 45),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                          color: Colors.white,
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
                ],
              ),
            ),
    );
  }

  void searchList(String query) {
    final suggestions = _additem.where((item) {
      final itemTitle = item.itemname!.toLowerCase();
      final input = query.toLowerCase();

      return itemTitle.contains(input);
    }).toList();

    setState(() => _additem = suggestions);
  }
}
