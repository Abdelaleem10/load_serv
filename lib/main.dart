import 'package:flutter/material.dart';
import 'package:loadserv_task/app_user.dart';
import 'package:loadserv_task/common/data/di/app_injector.dart';
import 'package:loadserv_task/product/presentation/ui/category_details_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();
  runApp(const TheAppUser());
}



