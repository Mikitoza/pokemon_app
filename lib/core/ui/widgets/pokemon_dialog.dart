import 'package:flutter/material.dart';

class PokemonDialog extends StatelessWidget {
  final String desc;

  const PokemonDialog({
    Key? key,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(desc),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
