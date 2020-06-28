import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optr/components/text_field.dart';
import 'package:optr/components/wrapper.dart';
import 'package:optr/helpers/build_barcode.dart';

class HomeScreen extends HookWidget {
  final String _title;

  HomeScreen(this._title);

  /// Route of the screen to be used for navigation
  static final String routeName = 'dashboard';

  @override
  Widget build(BuildContext context) {
    final run = useState(false);
    final svgPath = useState('');

    void _onBuildBarcode() async {
      final path = await buildBarcode('this is a test');
      run.value = true;
      svgPath.value = path;
    }

    return Scaffold(
      body: SafeArea(
        child: Wrapper(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    OptrTextField(label: 'Account ', onChanged: null),
                    SizedBox(height: 20),
                    OptrTextField(label: 'Name', onChanged: null),
                    SizedBox(height: 20),
                    Container(
                      color: Colors.white,
                      height: 200,
                      width: 200,
                      child: barCodeAnimated(svgPath.value, run: run.value),
                    ),
                    FlatButton(
                      child: Text('Build Barcode'),
                      onPressed: _onBuildBarcode,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Default Subtitle 1',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      'Titilium',
                      style: GoogleFonts.titilliumWeb(),
                    ),
                    // Counter(min: 1, onChanged: print),
                  ],
                ),
              ],
              // Expanded(child: OptrPadding(child: AccountList(accountsList)))
            ),
          ),
        ),
      ),
    );
  }
}
