import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:optr/components/spacer.dart';

import 'package:optr/modules/secret/secret.model.dart';
import 'package:optr/modules/secret/ui/secret_card.dart';

/// List that display account passwords
class SecretList extends HookWidget {
  final List<Secret> _list;

  /// Creates instance of the password list
  const SecretList(this._list);

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState<int>(0);

    if (_list == null || _list.isEmpty) {
      return const Center(child: Text('Add a Master Secret to get started'));
    }

    return Column(
      children: <Widget>[
        Container(
          height: 180,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              final secret = _list[index];
              return SecretCard(
                key: Key(_list[index].id),
                active: index == currentIndex.value,
                secret: secret,
                onPressed: () {},
              );
            },
            onIndexChanged: (index) => currentIndex.value = index,
            itemCount: _list.length,
            itemWidth: 400,
            itemHeight: 180,
            layout: SwiperLayout.TINDER,
          ),
        ),
      ],
    );
  }
}
