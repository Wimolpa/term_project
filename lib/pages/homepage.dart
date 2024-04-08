// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:term_project/helpers/api_caller.dart';
// import 'package:term_project/helpers/dialog_utils.dart';
// import 'package:term_project/helpers/my_text_fild.dart';
// import 'package:term_project/models/additem_models.dart';
// import 'package:term_project/models/todo_items.dart';
// import 'package:term_project/pages/additem.dart';
// import 'package:term_project/pages/reviewpage.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController _titleTextController = TextEditingController();
//   ProductsList _todoItems = ProductsList();
//   additem _additem = additem();
//   bool _isLoading = true;
//   bool _isLoading2 = true;
//   @override
//   void initState() {
//     super.initState();
//     _loadTodoItems();
//   }

//   Future<void> _loadTodoItems() async {
//     try {
//       final data = await ApiCaller().get("https://dummyjson.com/products");
//       // ข้อมูลที่ได้จาก API นี้จะเป็น JSON array ดังนั้นต้องใช้ List รับค่าจาก jsonDecode()
//       // List list = jsonDecode(data);
//       setState(() {
//         _todoItems = ProductsList.fromJson(jsonDecode(data));
//         _isLoading = false;
//       });
//     } on Exception catch (e) {
//       showOkDialog(context: context, title: "Error", message: e.toString());
//     }
//   }

//   Future<void> _loadTodoItems2() async {
//     try {
//       final data = await ApiCaller().get("test");
//       // ข้อมูลที่ได้จาก API นี้จะเป็น JSON array ดังนั้นต้องใช้ List รับค่าจาก jsonDecode()
//       // List list = jsonDecode(data);
//       setState(() {
//         _additem = additem.fromJson(jsonDecode(data));
//         _isLoading2 = false;
//       });
//     } on Exception catch (e) {
//       showOkDialog(context: context, title: "Error", message: e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var textTheme = Theme.of(context).textTheme;

//     return Scaffold(
//       backgroundColor: Colors.blue[50],
//       appBar: AppBar(
//           title: const Text('รายการ'), backgroundColor: Colors.blue[200]),
//       body: _isLoading
//           ? Text('TEST')
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   MyTextField(
//                     controller: _titleTextController,
//                     hintText: 'ชื่อสินค้า*',
//                   ),
//                   const SizedBox(height: 16),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: _todoItems.products!.length,
//                       itemBuilder: (context, index) {
//                         final item = _todoItems.products![index];
//                         debugPrint(_todoItems.products!.length.toString());
//                         debugPrint(item.id!.toString());
//                         if (item.category == 'skincare') {
//                           return Card(
//                             child: ListTile(
//                               title: Text(item.title!,
//                                   style: GoogleFonts.poppins()),
//                               subtitle: Text('ราคา: ${item.price!} USD',
//                                   style: GoogleFonts.poppins()),
//                               trailing: Image.network(
//                                 item.images![0].toString(),
//                                 width: 40,
//                                 height: 40,
//                               ),
//                               onTap: () {
//                                 print(item.images![0]);
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) {
//                                       return ReviewpPage(
//                                           item.title!,
//                                           item.price!,
//                                           item.description!,
//                                           item.images![0]);
//                                     },
//                                   ),
//                                 );
//                               },
//                             ),
//                           );
//                         } else {
//                           return Container();
//                         }
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 24.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return Additem();
//                       }));
//                     },
//                     child: const Text('เพิ่มสินค้า'),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
