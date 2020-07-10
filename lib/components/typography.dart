import 'package:flutter/material.dart';

class OptrTitle extends StatelessWidget {
  final String data;
  const OptrTitle(this.data, {Key key}) : super(key: key);
  // TODO: Implement this for all typography items
  static TextStyle style(BuildContext context) {
    return Theme.of(context).textTheme.headline5;
  }

  @override
  Widget build(BuildContext context) {
    return Text(data, style: OptrTitle.style(context));
  }
}

class OptrParagraph extends StatelessWidget {
  final String data;
  const OptrParagraph(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(data, style: Theme.of(context).textTheme.bodyText1);
  }
}

class OptrHeadline extends StatelessWidget {
  final String data;
  const OptrHeadline(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(data, style: Theme.of(context).textTheme.headline6);
  }
}

class OptrSubheading extends StatelessWidget {
  final String data;
  const OptrSubheading(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(data, style: Theme.of(context).textTheme.subtitle1);
  }
}

class OptrCaption extends StatelessWidget {
  final String data;
  const OptrCaption(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(data, style: Theme.of(context).textTheme.caption);
  }
}
