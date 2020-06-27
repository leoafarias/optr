import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optr/components/icon_button.dart';

/// Increment and decrement widget
class OptrCounter extends HookWidget {
  /// Current value of the counter
  final int _value;

  /// Callback function when counter is changed
  final void Function(int) onChanged;

  /// Min value of the counter
  final int min;

  /// Max value of the counter
  final int max;

  /// Constructor
  const OptrCounter({int value, this.onChanged, this.min = 0, this.max = 100})
      : _value = value ?? min;

  @override
  Widget build(BuildContext context) {
    final count = useState(_value);

    useEffect(() {
      if (_value > max && _value < min) {
        throw Exception(
            "Value needs to be within the min, and max counter range.");
      }
      return;
    }, []);

    // Call on changed when count changes
    useValueChanged(count.value, (_, __) {
      onChanged(count.value);
    });

    void increment() {
      count.value++;
    }

    void decrement() {
      if (count.value <= min) return;
      count.value--;
    }

    return Container(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            OptrIconButton(
              icon: Icon(Icons.remove),
              onPressed: decrement,
            ),
            SizedBox(width: 10.0, height: 60.0),
            ConstrainedBox(
                constraints: BoxConstraints(minWidth: 20.0),
                child: Text(count.value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0))),
            SizedBox(width: 10.0),
            OptrIconButton(
              icon: Icon(Icons.add),
              onPressed: increment,
            ),
          ],
        ),
      ),
    );
  }
}
