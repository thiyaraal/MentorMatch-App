// import 'package:flutter/material.dart';

// class NavbarMenuWidgetAdmin extends StatefulWidget {
//   final onPressed;

//   NavbarMenuWidgetAdmin({Key? key, this.onPressed}) : super(key: key);

//   @override
//   State<NavbarMenuWidgetAdmin> createState() => _NavbarMenuWidgetAdminState();
// }

// class _NavbarMenuWidgetAdminState extends State<NavbarMenuWidgetAdmin> {
//   void onPressed() {}
//   double _size = 250.0;

//   bool _large = true;


//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.menu, color: Colors.black87),
//             onPressed: onPressed,
//           ),
//           TextButton(
//             child: const Text(
//               'Products',
//               style: TextStyle(color: Colors.black87),
//             ),
//             onPressed: () {},
//           ),
//           TextButton(
//             child: const Text(
//               'Products',
//               style: TextStyle(color: Colors.black87),
//             ),
//             onPressed: () {},
//           ),
//           TextButton(
//             child: const Text(
//               'Category',
//               style: TextStyle(color: Colors.black87),
//             ),
//             onPressed: () {},
//           ),
//           const Spacer(),
//           IconButton(
//             icon: const Icon(Icons.brightness_3, color: Colors.black87),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon:
//                 const Icon(Icons.notification_important, color: Colors.black87),
//             onPressed: () {},
//           ),
//           const CircleAvatar(),
//         ],
//       ),
//     );
//   }
// }
