import 'package:event_calender/model/hat.dart';
import 'package:event_calender/screens/hats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

const hatColorPickerScreenRoute = '/hatColorPicker';

class HatColorPicker extends StatefulWidget {
  const HatColorPicker({super.key});

  @override
  State<HatColorPicker> createState() => _HatColorPickerState();
}

class _HatColorPickerState extends State<HatColorPicker> {
  IconData hatIcon = Icons.home;
  final _formKey = GlobalKey<FormState>();
  var hatName = '';
// create some values
  Color pickerColor = Colors.blue;
  Color currentColor = Colors.blue;

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() {
      currentColor = color;
      pickerColor = color;
    });
    //bool isColorIncluded = _defaultColors.any((colorItem) => colorItem['key'] == targetKey);
  }

  final List<Map<String, dynamic>> _defaultColors = [
    {
      'key': 'color1',
      'color': Colors.red,
    },
    {
      'key': 'color2',
      'color': Colors.purple,
    },
    {
      'key': 'color3',
      'color': Colors.blue,
    },
    {
      'key': 'color4',
      'color': Colors.cyan,
    },
    {
      'key': 'color5',
      'color': Colors.teal,
    },
    {
      'key': 'color6',
      'color': Colors.green,
    },
    {
      'key': 'color7',
      'color': Colors.lightGreen,
    },
    {
      'key': 'color8',
      'color': Colors.lime,
    },
    {
      'key': 'custom',
      'color': Colors.yellow,
    },
  ];

  Future<void> showColorPickerDialog() {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            // child: ColorPicker(
            //   pickerColor: pickerColor,
            //   onColorChanged: changeColor,
            // ),
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              colorPickerWidth: 300,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              labelTypes: const [ColorLabelType.hsl, ColorLabelType.hsv],
              displayThumbColor: true,
              paletteType: PaletteType.hsl,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
              hexInputBar: true,
              colorHistory:
                  _defaultColors.map<Color>((item) => item['color']).toList(),
              //onHistoryChanged: widget.onHistoryChanged,
            ),
          ),
        );
      },
    );
  }

  void saveHat() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context)
          .pop(Hat(hatName: hatName, hatColor: currentColor, hatIcon: hatIcon));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              saveHat();
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: hatBackgroundColor(currentColor),
                    ),
                    child: Icon(
                      hatIcon,
                      color: currentColor,
                      size: 80,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: hatName,
                        onSaved: (newValue) {
                          hatName = newValue!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Hat Name',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Select Color',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              BlockPicker(
                pickerColor: currentColor,
                onColorChanged: changeColor,
                availableColors:
                    _defaultColors.map<Color>((item) => item['color']).toList(),
              ),
              const SizedBox(height: 2),
              ElevatedButton(
                onPressed: () {
                  showColorPickerDialog();
                },
                child: const Text('Select a color'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
