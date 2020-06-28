import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optr/components/text_field.dart';
import 'package:optr/components/wrapper.dart';
import 'package:optr/helpers/build_barcode.dart';

class HomeScreen extends HookWidget {
  final String _title;

  const HomeScreen(this._title);

  /// Route of the screen to be used for navigation
  static const String routeName = 'dashboard';

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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Wrapper(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: <Widget>[
              const SizedBox(height: 20.0),
              Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  const OptrTextField(label: 'Account ', onChanged: null),
                  const SizedBox(height: 20),
                  const OptrTextField(label: 'Name', onChanged: null),
                  const SizedBox(height: 20),
                  Container(
                    color: Colors.white,
                    height: 200,
                    width: 200,
                    child: barCodeAnimated(svgPath.value, run: run.value),
                  ),
                  FlatButton(
                    child: const Text('Build Barcode'),
                    onPressed: _onBuildBarcode,
                  ),
                  const SizedBox(height: 20),
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
    );
  }
}
