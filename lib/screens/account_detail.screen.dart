import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:optr/components/counter.dart';
import 'package:optr/components/edges.dart';
import 'package:optr/components/text_field.dart';
import 'package:optr/components/frame.dart';

class AccountDetail extends HookWidget {
  final String _title;

  AccountDetail(this._title);

  /// Route of the screen to be used for navigation
  static final String routeName = 'account-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: OptrEdges(
                  corners: EdgeCorners.only(25, 25, 0, 0),
                  color: Color(0xFF111111),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text(
                          'Account Passcode',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(height: 20),
                        OptrTextField(label: 'Account Name', onChanged: null),
                        SizedBox(height: 10),
                        OptrTextField(label: 'Website', onChanged: null),
                        SizedBox(height: 10),
                        OptrTextField(label: 'Account Name', onChanged: null),
                        SizedBox(height: 20),
                        Frame(
                            child: Container(
                                child: Text(
                                    'Instructions about something go here to explain how versions work'))),
                        OptrCounter(
                          1,
                          (value) => print(value),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              OptrDoubleEdge(
                borderColor: Colors.teal,
                color: Color(0xFF111111),
                borderWidth: 1,
                corners: EdgeCorners.only(0, 0, 0, 40),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ],
            // Expanded(child: OptrPadding(child: AccountList(accountsList)))
          ),
        ),
      ),
    );
  }
}
