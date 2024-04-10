import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/helpers/api_caller.dart';
import 'package:term_project/helpers/dialog_utils.dart';
import 'package:term_project/pages/homepage.dart';

class Additem extends StatefulWidget {
  const Additem({super.key});

  @override
  State<Additem> createState() => _AdditemState();
}

class _AdditemState extends State<Additem> {
  var _titleController = TextEditingController();
  var _piceController = TextEditingController();
  var _imageController = TextEditingController();
  var _desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          'เพิ่มสินค้า',
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "เพิ่มรายการสินค้า",
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFf5f5f5),
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
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _desController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFf5f5f5),
                    contentPadding: const EdgeInsets.only(
                      left: 16.0,
                      bottom: 12.0,
                      top: 12.0,
                    ),
                    hintText: 'คำอธิบายสินค้า*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _piceController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFf5f5f5),
                    contentPadding: const EdgeInsets.only(
                      left: 16.0,
                      bottom: 12.0,
                      top: 12.0,
                    ),
                    hintText: 'ราคา*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _imageController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFf5f5f5),
                    contentPadding: const EdgeInsets.only(
                      left: 16.0,
                      bottom: 12.0,
                      top: 12.0,
                    ),
                    hintText: 'URL ภาพสินค้า*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    print('Itemname: ${_titleController.text}');
                    print('Price: ${_piceController.text}');
                    print('Image: ${_imageController.text}');
                    var caller = ApiCaller();
                    var data = await caller.post(
                      'product',
                      params: {
                        "itemname": _titleController.text,
                        "price":
                            // parse int
                            int.parse(_piceController.text),
                        "image": _imageController.text,
                        "description": _desController.text
                      },
                    );
                    // debugPrint(data);
          
                    if (_titleController.text.length == '' ||
                        _piceController.text == '' ||
                        _imageController.text == '') {
                      print('error:');
                      showOkDialog(
                          context: context,
                          title: "เพิ่มสินค้าไม่สําเร็จ!",
                          message: "กรุณากรอกข้อมูลให้ครบ");
                    } else {
                      showOkDialog(
                          context: context,
                          title: "เพิ่มสินค้าสําเร็จ!",
                          message: _titleController.text);
                    }
                  },
                  child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('เพิ่ม',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.green)),
                          // Icon(Icons.check, color: Colors.green),
                        ],
                      )),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                        const Size(100, 30),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.network(
                          'https://media.istockphoto.com/id/1170104811/photo/keep-your-skin-clean.jpg?s=612x612&w=0&k=20&c=VmZZ11qES2XVYSlTj-8Baqdyioutctczr6qHq0jB5_Y=',
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                      Expanded(
                        child: Image.network(
                          'https://media.istockphoto.com/id/1297629145/photo/cosmetic-moisturizing-face-cream-with-vitamin-c-oranges-and-jars-with-cream-on-a-blue.webp?b=1&s=170667a&w=0&k=20&c=CwNc2lb1Hns1l_7ZVo7K82iEBXlLNLK-mg8md1B1-eg=',
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                      Expanded(
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_bYdJEpYH5FNbYx85VqxBCbIDa-BLfdMHvRUHCINpjQ&s',
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7sLWnOJpm-ZFu6GiJ_plJefdkihgD3eoV2KOnlRkgOQ&s',
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                      Expanded(
                        child: Image.network(
                          'https://j6y9q7k7.rocketcdn.me/wp-content/uploads/2022/03/skincare-products-creative-lifestyle-photography-nyc-2.jpg',
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                      Expanded(
                        child: Image.network(
                          'https://static.thcdn.com/images/large/original//productimg/1600/1600/12870631-1904869462991317.jpg',
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
