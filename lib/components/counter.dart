import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optr/components/edges.dart';

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

  /// Field color
  Color color;

  /// Constructor
  OptrCounter(
      {@required this.onChanged,
      int value,
      this.min = 0,
      this.max = 100,
      this.color})
      : _value = value ?? min;

  @override
  Widget build(BuildContext context) {
    final count = useState(_value);

    useEffect(() {
      if (_value > max && _value < min) {
        throw Exception(
            'Value needs to be within the min, and max counter range.');
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

    // Set default color
    color ??= Theme.of(context).accentColor;

    return OptrDoubleEdge(
      color: Colors.black.withOpacity(0.9),
      borderColor: color,
      corners: const EdgeCorners.cross(10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 10),
          Expanded(
              child: Text('Version',
                  style: Theme.of(context).textTheme.subtitle1)),
          Container(
            child: IconButton(
              icon: Icon(Icons.remove),
              onPressed: decrement,
            ),
          ),
          const SizedBox(width: 10.0),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 20.0),
            child: Text(
              count.value.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            color: Colors.black,
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: increment,
            ),
          ),
        ],
      ),
    );
  }
}
