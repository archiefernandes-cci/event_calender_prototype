import 'package:flutter/material.dart';

class TestStickyWidget extends StatefulWidget {
  final String header;
  final String content;

  const TestStickyWidget({super.key, required this.header, required this.content});

  @override
  State<TestStickyWidget> createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<TestStickyWidget> {

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.header),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(widget.content),
        ),
      ],
    );
  }
}