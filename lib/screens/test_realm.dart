// import 'package:event_calender/model/realm_test.dart';
// import 'package:flutter/material.dart';
// import 'package:realm/realm.dart';

// const realmTestRoute = '/realmTest';

// class TestRealm extends StatefulWidget {
//   const TestRealm({super.key});

//   @override
//   State<TestRealm> createState() => _TestRealmState();
// }

// class _TestRealmState extends State<TestRealm> {
//   String realmText = '';
//   String tempText = '';

//   var config = Configuration.local([RealmTest.schema], schemaVersion: 3);
//   late Realm realm;

//   @override
//   void initState() {
//     super.initState();

//     realm = Realm(config);

//     var tempObject = realm.query<RealmTest>(r'id == $0', [01]);

//     if (tempObject.isNotEmpty) {
//       setState(() {
//         realmText = tempObject[0].testString;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     realm.close();
//     super.dispose();
//   }

//   void handleSubmit() {
//     RealmTest tempItem = RealmTest(01, 'TestInput', tempText);

//     var tempObject = realm.query<RealmTest>(r'id == $0', [01]);

//     if (tempObject.isEmpty) {
//       realm.write(() {
//         realm.add(tempItem);
//       });
//     } else {
//       var updatedObject = tempObject[0];
//       print('old text text ${updatedObject.testString}');
//       realm.write(() {
//         updatedObject.testString = tempText;
//       });
//       print('Temp object length ${tempObject.length}');
//       print('Temp object ${tempObject[0].testString}');
//     }

//     //how to check if read and write is successful ??
//     setState(() {
//       realmText = tempText;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Realm DB test'),
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//         child: Column(
//           children: [
//             TextField(
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Test the input',
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   tempText = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 50),
//             TextButton(
//                 onPressed: () {
//                   handleSubmit();
//                 },
//                 child: const Text('Submit Text')),
//             const SizedBox(height: 50),
//             Text('Text from the realm: $realmText'),
//           ],
//         ),
//       ),
//     );
//   }
// }
