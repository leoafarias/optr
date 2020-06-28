import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optr/modules/account/account.model.dart';
import 'package:optr/modules/secret/secret.model.dart';
import 'package:optr/screens/account_detail.screen.dart';
import 'package:optr/screens/secret_detail.screen.dart';
import 'package:optr/theme.dart';

void main() async {
  // [Hive] 0. Create adapters specifying how to read and write the model
  // [Hive] 1. Init and register Hive Adapters
  // [Hive] 2. When needed, open Hive box :
  // (If the box is already open, the instance is returned and all provided parameters are being ignored.)
  // ```
  // final accountBox = await Hive.openBox<Account>(AccountRepo.boxName);
  // final secretBox = await Hive.openBox<Secret>(SecretRepo.boxName);
  // ```
  // [Hive] 3. Use a previously opened box:
  // ```
  // accountBox.put(key, model); // OR
  // Hive.box<Account>(AccountRepo.boxName).put(key, model);
  // ```
  await Hive.initFlutter();
  Hive.registerAdapter<Account>(AccountAdapter());
  Hive.registerAdapter<Secret>(SecretAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: darkTheme(),
        debugShowCheckedModeBanner: false,
        home: SecretDetail(),
      ),
    );
  }
}
