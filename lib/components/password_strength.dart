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
    final passwordStrength = useState(getPasswordStrength(result));
    final color = useState(Colors.transparent);

    useValueChanged(result, (_, __) {
      passwordStrength.value = getPasswordStrength(result);
      color.value = passwordStrength.value.strength < 0.7
          ? Colors.deepOrangeAccent
          : Colors.tealAccent;
    });

    if (passwordStrength.value.strength == 0.0) return Empty;

    return Column(
      children: <Widget>[
        LinearPercentIndicator(
          // width: 140.0,
          lineHeight: 14.0,
          animateFromLastPercent: true,
          animation: true,
          leading: const Text('Weak'),
          trailing: const Text('Strong'),
          percent: passwordStrength.value.strength,

          backgroundColor: Colors.white.withOpacity(0.1),
          linearStrokeCap: LinearStrokeCap.butt,
          animationDuration: 500,
          // curve: Curves.easeInCubic,
          progressColor: color.value,
        ),
        const OptrSpacer(),
        Text('Approximate Crack Time: ${passwordStrength.value.message}'),
      ],
    );
  }
}
