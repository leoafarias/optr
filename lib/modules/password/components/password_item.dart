import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:optr/components/avatar.dart';
import 'package:optr/components/typography.dart';
import 'package:optr/modules/password/password.model.dart';
import 'package:optr/screens/password_detail_screen.dart';

/// Item that dislpays the account password within the list
class PasswordItem extends StatelessWidget {
  /// Account model
  final Password password;

  /// Constrctor for the password Item
  PasswordItem(this.password) : super(key: Key(password.id));

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      tappable: true,
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      transitionType: ContainerTransitionType.fade,
      transitionDuration: const Duration(milliseconds: 100),
      closedBuilder: (context, action) => _buildContainer(context),
      openBuilder: (context, action) => PasswordDetail(id: password.id),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return LimitedBox(
      maxHeight: 200,
      maxWidth: double.infinity,
      child: ListTile(
        leading: OptrAvatar(password.name),
        title: OptrHeadline(password.name),
        subtitle: OptrSubheading(password.website),
        trailing: IconButton(
          icon: Icon(Icons.content_copy),
          onPressed: () {},
        ),
      ),
    );
  }
}
