import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optr/components/text_field.dart';
import 'package:optr/components/wrapper.dart';

class HomeScreen extends HookWidget {
  final String _title;

  HomeScreen(this._title);

  /// Route of the screen to be used for navigation
  static final String routeName = 'dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: SafeArea(
        child: Wrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  OptrTextField(label: 'Account ', onChanged: null),
                  SizedBox(height: 20),
                  // Counter(min: 1, onChanged: print),
                ],
              ),
            ],
            // Expanded(child: OptrPadding(child: AccountList(accountsList)))
          ),
        ),
      ),
    );
  }
}
