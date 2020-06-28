import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
        child: Wrapper(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: <Widget>[
              const SizedBox(height: 20.0),
              const SizedBox(height: 20),
              const OptrTextField(label: 'Account ', onChanged: null),
              const SizedBox(height: 20),
              const OptrTextField(label: 'Name', onChanged: null),
              const SizedBox(height: 20),
              Frame(
                color: Colors.black,
                lineColor: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.tealAccent.withAlpha(150),
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                  )
                ],
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text('Customized Frame'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
    );
  }
}
