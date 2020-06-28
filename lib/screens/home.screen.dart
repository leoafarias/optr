import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optr/components/button.dart';
import 'package:optr/components/cut_edges_decoration.dart';
import 'package:optr/components/frame.dart';
import 'package:optr/components/text_field.dart';
import 'package:optr/components/wrapper.dart';
import 'package:optr/helpers/build_barcode.dart';

class HomeScreen extends HookWidget {
  const HomeScreen();

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const CutEdgesDecoration(
              lineStroke: 3.0,
              lineColor: Color.fromRGBO(10, 10, 10, 1.0),
              edges: CutEdgeCorners.all(25.0, 25.0, 0.0, 40.0),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: <Widget>[
                const SizedBox(height: 20.0),
                const SizedBox(height: 20),
                const OptrTextField(label: 'Account ', onChanged: null),
                const SizedBox(height: 20),
                const OptrTextField(label: 'Name', onChanged: null),
                const SizedBox(height: 40),
                OptrButton(
                  label: 'Cyberpunk',
                  style: GoogleFonts.orbitron(),
                ),
                const SizedBox(height: 40),
                OptrButton.success(
                  label: 'Success',
                  icon: Icons.thumb_up,
                ),
                const SizedBox(height: 40),
                OptrButton.error(
                  label: 'Error',
                  icon: Icons.clear,
                ),
                const SizedBox(height: 40),
                Frame(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          color: Colors.white,
                          height: 200,
                          width: 200,
                          child: barCodeAnimated(svgPath.value, run: run.value),
                        ),
                      ),
                      FlatButton(
                        child: const Text('Build Barcode'),
                        onPressed: _onBuildBarcode,
                      ),
                    ],
                  ),
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
