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
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "เพิ่มรายการสินค้า",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
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
                border: OutlineInputBorder(),
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
                border: OutlineInputBorder(),
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
                border: OutlineInputBorder(),
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
                border: OutlineInputBorder(),
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
                child: Text('เพิ่ม',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue[700])),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                Colors.white,
              )),
            )
          ],
        ),
      ),
    );
  }
}
