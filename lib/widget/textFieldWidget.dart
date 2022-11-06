import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    required this.label,
    required this.text,
    required this.onChanged
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {

  late final TextEditingController controller;

  @override//Initializing TextEditingController
  void initState(){
    super.initState();
    controller = TextEditingController(text: widget.text); //initial state of the textfield
  }

  @override//Disposing controller to clean it
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: textColor),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),

          ),
          controller: controller,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged, //Calling the onChanged callback at the top to get the new value that we type in the text field
        ),
      ],
    );
  }
}
