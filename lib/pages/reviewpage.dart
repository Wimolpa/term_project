// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:term_project/helpers/api_caller.dart';
// import 'package:term_project/helpers/dialog.dart';
// import 'package:term_project/helpers/my_text_fild.dart';
// import 'package:term_project/models/user.dart';
// import 'package:term_project/pages/homepage.dart';

// class ReviewpPage extends StatelessWidget {
//   String? title;
//   int? price;
//   String? description;
//   String? images;
//   var _commentController = TextEditingController();
//   User _todoItems = User();

//   ReviewpPage(String? title, int? price, String? description, String? images) {
//     this.title = title!;
//     this.price = price!;
//     this.description = description!;
//     this.images = images!;
//   }
//   Future<void> _loadTodoItems() async {
//     try {
//       final data = await ApiCaller().get("https://dummyjson.com/products");
//       // ข้อมูลที่ได้จาก API นี้จะเป็น JSON array ดังนั้นต้องใช้ List รับค่าจาก jsonDecode()
//       // List list = jsonDecode(data);
//       setState(() {
//         _todoItems = User.fromJson(jsonDecode(data));
//         // _isLoading = false;
//       });

//     } on Exception catch (e) {
//       // showOkDialog(context: context, title: "Error", message: e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue[200],
//         title: Text(
//           'รีวิว',
//           style: GoogleFonts.poppins(),
//         ),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(20.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10.0),
//                     child: Image.network(
//                       images!.toString(),
//                       width: 150.0,
//                       height: 150.0,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12.0),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title!.toString(),
//                         style: GoogleFonts.poppins(
//                           color: Colors.black,
//                           fontSize: 35.0,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       Text(
//                         'ราคา: ${price!} USD',
//                         style: GoogleFonts.poppins(
//                           color: Colors.black,
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Text(
//                         'คำอธิบาย: $description',
//                         style: GoogleFonts.poppins(
//                           color: Color(0xFFAEAEAE),
//                           fontSize: 13.0,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(20.0),
//                   child: Text(
//                     'ความคิดเห็น',
//                     style: GoogleFonts.poppins(
//                       color: Colors.black,
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.only(
//                     left: 5.0, right: 5.0, top: 20.0, bottom: 5.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 6,
//                           child: TextField(
//                             controller: _commentController,
//                             decoration: InputDecoration(
//                               hintText: 'แสดงความคิดเห็น',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           //     MyTextField(
//                           //   controller: _commentController,
//                           //   hintText: 'แสดงความคิดเห็น',
//                           // ),
//                         ),
//                         SizedBox(width: 12.0),
//                         Expanded(
//                           // flex: 1,
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                               shape: MaterialStateProperty.all<OutlinedBorder>(
//                                   RoundedRectangleBorder()),
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   Colors.blue[200]!),
//                               minimumSize: MaterialStateProperty.all<Size>(
//                                   const Size(60, 60)),
//                             ),
//                             onPressed: () async {
//                               var caller = ApiCaller();
//                               var data = await caller.post(
//                                 'comment',
//                                 params: {
//                                   "id": pid,
//                                   "comment": _commentController.text
//                                 },
//                               );
//                               // debugPrint(data);

//                               if (_titleController.text.length == '' ||
//                                   _piceController.text == '' ||
//                                   _imageController.text == '') {
//                                 print('error:');
//                                 showOkDialog(
//                                     context: context,
//                                     title: "เพิ่มสินค้าไม่สําเร็จ!",
//                                     message: "กรุณากรอกข้อมูลให้ครบ");
//                               } else {
//                                 showOkDialog(
//                                     context: context,
//                                     title: "เพิ่มสินค้าสําเร็จ!",
//                                     message: _titleController.text);
//                               }
//                             },
//                             child: Container(
//                                 width: double.infinity,
//                                 child: Center(
//                                     child: Icon(
//                                   Icons.arrow_upward,
//                                   color: Colors.blue[700],
//                                 ))),
//                           ),
//                         ),
//                         SizedBox(width: 12.0),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
