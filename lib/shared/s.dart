// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//
// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Manager'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showTaskAlert(context);
//           },
//           child: Text('Create Task'),
//         ),
//       ),
//     );
//   }
// }
//
// void showTaskAlert(BuildContext context) {
//   String taskTitle = '';
//   String taskDescription = '';
//   DateTime selectedDateTime = DateTime.now();
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Create Task'),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Task Title',
//                 ),
//                 onChanged: (value) {
//                   taskTitle = value;
//                 },
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Task Description',
//                 ),
//                 onChanged: (value) {
//                   taskDescription = value;
//                 },
//               ),
//               SizedBox(height: 10), // Add some spacing
//               ElevatedButton(
//                 onPressed: () {
//                   DatePicker.showDateTimePicker(
//                     context,
//                     showTitleActions: true,
//                     onChanged: (date) {
//                       selectedDateTime = date;
//                     },
//                     onConfirm: (date) {
//                       selectedDateTime = date;
//                     },
//                   );
//                 },
//                 child: Text('Select Date and Time'),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               // Handle saving the task with the entered details
//               // You can access taskTitle, taskDescription, and selectedDateTime here
//               Navigator.pop(context);
//             },
//             child: Text('Save'),
//           ),
//         ],
//       );
//     },
//   );
// }