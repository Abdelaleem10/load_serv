import 'package:flutter/material.dart';
import 'package:loadserv_task/app_user.dart';
import 'package:loadserv_task/common/data/di/app_injector.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();
  runApp(const TheAppUser());
}



