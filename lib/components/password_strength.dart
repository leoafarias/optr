import 'package:flutter/material.dart';
import 'package:optr/components/empty_space.dart';
import 'package:optr/components/spacer.dart';
import 'package:optr/helpers/seconds_to_readable.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:xcvbnm/xcvbnm.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PasswordStrengthDisplay extends HookWidget {
  final Result result;
  const PasswordStrengthDisplay(this.result);

  @override
  Widget build(BuildContext context) {
    final score = useState<int>(0);

    useValueChanged(result, (_, __) {
      score.value = result.score;
    });

    if (result == null || result.score == null) return Empty;
    final crackTime = convertSecondsToReadable(result.crackTime);

    return Column(
      children: <Widget>[
        LinearPercentIndicator(
          // width: 140.0,
          lineHeight: 14.0,
          animation: true,
          animateFromLastPercent: true,
          percent: score.value * 0.25,
          backgroundColor: Theme.of(context).cardColor,
          progressColor: Theme.of(context).accentColor,
        ),
        const OptrSpacer(),
        Text('Approximate Crack Time: $crackTime'),
      ],
    );
  }
}
