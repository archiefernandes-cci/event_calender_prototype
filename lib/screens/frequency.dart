import 'package:event_calender/screens/custom_frequency.dart';
import 'package:flutter/material.dart';

const frequencyScreenRoute = '/frequency';

final defaultFrequencyList = [
  'Never',
  'Every Day',
  'Every Weekday',
  'Every Weekend',
  'Every Week',
  'Every 2 weeks',
  'Every Month',
  'Every Year',
];
const customText = 'Custom';

class Frequency extends StatefulWidget {
  const Frequency({super.key});

  @override
  State<Frequency> createState() => _FrequencyState();
}

class _FrequencyState extends State<Frequency> {
  var frequencyButtonText = defaultFrequencyList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Repeat Frequency'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: defaultFrequencyList.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (ctx, index) {
                return ListTile(
                  selected: frequencyButtonText == defaultFrequencyList[index],
                  selectedTileColor: Colors.lightGreen,
                  title: Text(defaultFrequencyList[index]),
                  onTap: () {
                    setState(() {
                      frequencyButtonText = defaultFrequencyList[index];
                    });
                  },
                );
              },
            ),
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_right),
            title: const Text(customText),
            selected: frequencyButtonText == customText,
            selectedTileColor: Colors.lightGreen,
            onTap: () {
              setState(() {
                frequencyButtonText = customText;
              });
              Navigator.of(context).pushNamed(customFrequencyScreenRoute);
            },
          )
        ],
      ),
    );
  }
}
