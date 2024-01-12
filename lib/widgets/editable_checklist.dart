import 'package:flutter/material.dart';

class EditableChecklist extends StatefulWidget {
  const EditableChecklist({super.key, required this.eventNotes, });
  final List<String> eventNotes;
  
  @override
  State<EditableChecklist> createState() => _EditableChecklistState();
}

class _EditableChecklistState extends State<EditableChecklist> {
  TextEditingController noteFieldController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void handleNotesSubmit(String note) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        widget.eventNotes.add(note);
        noteFieldController.clear();
      });
    }
  }

  void handleListItemEdit(String value, int arrayIndex) {
    setState(() {
      widget.eventNotes[arrayIndex] = value;
    });
  }

  @override
  void dispose() {
    noteFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var eventNotes = widget.eventNotes;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: 300,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                maxLines: null,
                controller: noteFieldController,
                textInputAction: TextInputAction.go,
                onFieldSubmitted: (value) {
                  handleNotesSubmit(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              if (eventNotes.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: eventNotes.length,
                    itemBuilder: (context, index) {
                      return Padding(
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
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                initialValue: eventNotes[index],
                                maxLines: null,
                                textInputAction: TextInputAction.go,
                                onFieldSubmitted: (value) {
                                  handleListItemEdit(value, index);
                                },
                              ),
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
