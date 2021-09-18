import 'package:flutter/material.dart';

class AppHintText extends StatelessWidget {
  final String text;

  const AppHintText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.caption?.copyWith(fontStyle: FontStyle.italic));
  }
}

class AppWarningCard extends StatelessWidget {
  final Widget message;

  const AppWarningCard(this.message);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.warning_amber_rounded),
          ),
          Expanded(
            child: Padding(padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8), child: message),
          ),
        ],
      ),
    );
  }
}
