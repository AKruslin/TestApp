import 'package:flutter/material.dart';

import 'di/injection.dart';
import 'main.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Env.development);
  runApp(const MyApp());
}