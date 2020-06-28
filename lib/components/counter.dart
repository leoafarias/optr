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

  /// Constructor
  const OptrCounter(int value, this.onChanged, {this.min = 0, this.max = 100})
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

    return OptrEdges(
      color: Colors.black,
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
