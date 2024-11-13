// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class HelperPage extends StatefulWidget {
//   const HelperPage({super.key});

//   @override
//   State<HelperPage> createState() => _HelperPageState();
// }

// class _HelperPageState extends State<HelperPage> {
//   String userId = "", title = "", id = "";

//   List almubList = [];

//   Future fetchAlbum() async {
//     var response = await http
//         .get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));

//     if (response.statusCode == 200) {
//       var decodedData = json.decode(response.body);
//       almubList = decodedData;

//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   fetchAlbum();
//                 },
//                 child: const Text("data")),
//             Expanded(
//                 child: ListView.separated(
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       var data = almubList[index];
//                       return Card(
//                         child: Column(
//                           children: [
//                             Text(data['userId'].toString()),
//                             Text(data['title'].toString()),
//                             Text(data['id'].toString()),
//                           ],
//                         ),
//                       );
//                     },
//                     separatorBuilder: (BuildContext, int) => const SizedBox(
//                           height: 10,
//                         ),
//                     itemCount: almubList.length))
//           ],
//         ),
//       ),
//     );
//   }
// }
