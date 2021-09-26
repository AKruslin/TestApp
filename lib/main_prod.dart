import 'package:flutter/material.dart';
import 'package:test_app/di/injection.dart';

import 'main.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Env.production);
  runApp(const MyApp());
}