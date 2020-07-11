import 'dart:async';

Map timeouts = {};

void debounce<T>(int timeoutMS, Function target, {List arguments = const []}) {
  if (timeouts.containsKey(target)) {
    timeouts[target].cancel();
  }

  final timer = Timer(Duration(milliseconds: timeoutMS), () {
    Function.apply(target, arguments);
  });

  timeouts[target] = timer;
}

void defer<T>(Function target, {List arguments}) {
  Timer(const Duration(milliseconds: 0), () {
    Function.apply(target, arguments);
  });
}
