import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'app/app.dart';
import 'injection/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = await openDatabase('my_db.db');

  await initInjection();
  runApp(const MyApp());
}
