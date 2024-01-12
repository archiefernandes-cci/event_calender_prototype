import 'package:event_calender/model/hat.dart';
import 'package:event_calender/screens/hat_color_picker.dart';
import 'package:flutter/material.dart';

const hatsScreenRoutes = '/hats';

class HatArguments {}

class Hats extends StatefulWidget {
  const Hats({super.key});

  @override
  State<Hats> createState() => _HatsState();
}

class _HatsState extends State<Hats> {
  List<Hat> hatList = [
    Hat(hatName: 'Me', hatColor: Colors.orange, hatIcon: Icons.star),
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   final newHat = widget.newHat;
  //   if (newHat != null) {
  //     setState(() {
  //       hatList.add(
  //         Hat(
  //           hatColor: newHat.hatColor,
  //           hatIcon: newHat.hatIcon,
  //           hatName: newHat.hatName,
  //         ),
  //       );
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select Hat'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(hatColorPickerScreenRoute).then((value) {
                if(value != null && value is Hat){
                  setState(() {
                    hatList.add(value);
                  });
                }
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          children: [
            if (hatList.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: hatList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: hatBackgroundColor(hatList[index].hatColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        hatList[index].hatIcon,
                        color: hatList[index].hatColor,
                        size: 45,
                      ),
                    ),
                    title: Text(hatList[index].hatName),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
