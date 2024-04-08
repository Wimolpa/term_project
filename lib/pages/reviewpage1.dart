import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:term_project/helpers/api_caller.dart';
import 'package:term_project/helpers/dialog.dart';
import 'package:term_project/helpers/my_text_fild.dart';
import 'package:term_project/models/user.dart';
import 'package:term_project/pages/homepage.dart';

class ReviewpPage1 extends StatefulWidget {
  String? title;
  int? price;
  String? description;
  String? images;
  int? pid;
  ReviewpPage1(
      String? title, int? price, String? description, String? images, int? pid,
      {super.key}) {
    this.title = title!;
    this.price = price!;
    this.description = description!;
    this.images = images!;
    this.pid = pid!;
  }
  @override
  State<ReviewpPage1> createState() => _reviewPageState();
}

class _reviewPageState extends State<ReviewpPage1> {
  var _commentController = TextEditingController();
  List<User> _todoItems = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadTodoItems();
  }

  Future<void> _loadTodoItems() async {
    try {
      final data = await ApiCaller().get("http://localhost:3000/comment");
      // ข้อมูลที่ได้จาก API นี้จะเป็น JSON array ดังนั้นต้องใช้ List รับค่าจาก jsonDecode()
      List list = jsonDecode(data);

      setState(() {
        _todoItems = list.map((e) => User.fromJson(e)).toList();
        _isLoading = false;
      });
    } on Exception catch (e) {
      // showOkDialog(context: context, title: "Error", message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          'รีวิว',
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      widget.images!.toString(),
                      width: 150.0,
                      height: 150.0,
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title!.toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'ราคา: ${widget.price!} USD',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'คำอธิบาย: ${widget.description}',
                        style: GoogleFonts.poppins(
                          color: Color(0xFFAEAEAE),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Text(
                    'ความคิดเห็น',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      // itemCount: _todoItems.comment!.length,
                      itemCount: _todoItems.length,
                      itemBuilder: (context, index) {
                        print(index);
                        List<Card> comment = [];
                        for (int i = 0;
                            i < _todoItems[index].comment!.length;
                            i++) {
                          if (_todoItems[index].comment![i].pid! ==
                              widget.pid!) {
                            comment.add(Card(
                              child: ListTile(
                                title: Text(
                                  _todoItems[index].comment![i].content!,
                                ),
                              ),
                            ));
                          }
                        }

                        return Column(children: comment);

                        // final item = _todoItems[index].comment;
                        // debugPrint(
                        //     _todoItems.products!.length.toString());
                        // // debugPrint(item.id!.toString());
                        // if (item.pid! == widget.pid!) {
                        //   return Card(
                        //     child: ListTile(
                        //       // title: Text(item.,
                        //       //     style: GoogleFonts.poppins()),
                        //       subtitle: Text('--> ${item.content!}',
                        //           style: GoogleFonts.poppins()),
                        //     ),
                        //   );
                        // } else {
                        //   return Container();
                        // }
                      },
                    ),
                  ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 20.0, bottom: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              hintText: 'แสดงความคิดเห็น',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          // flex: 1,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder()),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue[200]!),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(60, 60)),
                            ),
                            onPressed: () async {
                              var caller = ApiCaller();
                              var data = await caller.post(
                                'comment',
                                params: {
                                  // fix later
                                  // "id": _todoItems[0].toString(),
                                  "comment": _commentController.text
                                },
                              );
                              // debugPrint(data);

                              if (_commentController.text.length == '') {
                                print('error:');
                              } else {
                                showOkDialog(
                                    context: context,
                                    title: "สำเร็จ",
                                    status: "");
                              }
                            },
                            child: Container(
                                width: double.infinity,
                                child: Center(
                                    child: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.blue[700],
                                ))),
                          ),
                        ),
                        SizedBox(width: 12.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
