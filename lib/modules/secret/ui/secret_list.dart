import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:optr/modules/secret/secret.model.dart';
import 'package:optr/modules/secret/ui/secret_card.dart';

/// List that display account passwords
class SecretList extends HookWidget {
  final List<Secret> list;
  final bool simpleCard;
  final Function(int) onIndexChange;
  final int initialIndex;

  /// Creates instance of the password list
  const SecretList(this.list,
      {this.simpleCard = false, this.onIndexChange, this.initialIndex = 1});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState<int>(0);

    void handleIndexChange(int index) {
      currentIndex.value = index;
      if (onIndexChange.call != null) {
        onIndexChange(index);
      }
    }

    if (list == null || list.isEmpty) {
      return const Center(
        child: Text('Add a Master Secret to get started'),
      );
    }

    return Column(
      children: <Widget>[
        Container(
          height: 180,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              final secret = list[index];
              return SecretCard(
                key: Key(list[index].id),
                simpleCard: simpleCard,
                active: index == currentIndex.value,
                secret: secret,
              );
            },
            onIndexChanged: handleIndexChange,
            itemCount: list.length,
            itemWidth: 400,
            itemHeight: 180,
            layout: SwiperLayout.TINDER,
          ),
        ),
      ],
    );
  }
}
