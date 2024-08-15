import 'package:flutter/material.dart';

class MultipleValuesTextField extends StatelessWidget {
  final TextEditingController controller;
  final List<String> values;
  final Function(String) onSubmitted;
  final Function() onAddPressed;
  final Function(int) onDeletePressed;

  MultipleValuesTextField({
    required this.controller,
    required this.values,
    required this.onSubmitted,
    required this.onAddPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Enter a value',
            ),
            onSubmitted: onSubmitted,
          ),
        ),
        ElevatedButton(
          onPressed: onAddPressed,
          child: Text('Add Value'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: values.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(values[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    onDeletePressed(index);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}