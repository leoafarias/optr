import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/modules/password/password.model.dart';
import 'package:optr/modules/secret/secret.model.dart';
import 'package:optr/modules/word_icon/word_icon.repo.dart';
import 'package:optr/screens/home.screen.dart';
import 'package:optr/screens/password_detail_screen.dart';
import 'package:optr/screens/password_list_screen.dart';
import 'package:optr/screens/secret_detail.screen.dart';
import 'package:optr/theme.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Password>(PasswordAdapter());
  Hive.registerAdapter<Secret>(SecretAdapter());
  Hive.registerAdapter<WordIcon>(WordIconAdapter());
  WordIconRepo.openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkTheme(),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          SecretDetail.routeName: (context) => SecretDetail(),
          PasswordDetail.routeName: (context) => PasswordDetail(),
        },
      ),
    );
  }
}
