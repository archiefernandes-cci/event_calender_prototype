import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditableNotes extends StatefulWidget {
  const EditableNotes({
    super.key,
    required this.eventNotes,
  });
  final List<String> eventNotes;

  @override
  State<EditableNotes> createState() => _EditableNotesState();
}

class _EditableNotesState extends State<EditableNotes> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int autofocusIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.eventNotes.isEmpty) {
      widget.eventNotes.add('');
    }
  }

  void handleNotesSubmit(String note, int index) {
    if (note.isNotEmpty &&
        ((widget.eventNotes.asMap().containsKey(index + 1) &&
                widget.eventNotes[index + 1].isNotEmpty) ||
            !widget.eventNotes.asMap().containsKey(index + 1))) {
      setState(() {
        widget.eventNotes.insert(index + 1, '');
        autofocusIndex = index + 1;
      });
    }
  }

  void handleListItemEdit(String value, int arrayIndex) {
    widget.eventNotes[arrayIndex] = value;
  }

  void removeNote(String noteItem) {
    setState(() {
      widget.eventNotes.remove(noteItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    var eventNotes = widget.eventNotes;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (eventNotes.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: eventNotes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        key: ValueKey(DateTime.now().millisecondsSinceEpoch),
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.circle_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: RawKeyboardListener(
                                focusNode: FocusNode(canRequestFocus: false),
                                onKey: (RawKeyEvent event) {
                                  if (eventNotes.length > 1 &&
                                      event.isKeyPressed(
                                          LogicalKeyboardKey.backspace) &&
                                      eventNotes[index].isEmpty) {
                                    removeNote(eventNotes[index]);
                                   
                                    if (index > 0) {
                                      autofocusIndex = index - 1;
                                    } else {
                                      autofocusIndex = index;
                                    }
                                  }
                                  if (event
                                      .isKeyPressed(LogicalKeyboardKey.abort)) {
                                    setState(() {
                                      autofocusIndex = -1;
                                    });
                                  }
                                },
                                child: TextFormField(
                                  autofocus: index == autofocusIndex,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  initialValue: eventNotes[index],
                                  maxLines: null,
                                  textInputAction: TextInputAction.go,
                                  onFieldSubmitted: (value) {
                                    handleNotesSubmit(value, index);
                                  },
                                  onChanged: (value) {
                                    handleListItemEdit(value, index);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
