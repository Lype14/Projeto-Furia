import 'package:aplicativo_furia/app/controllers/live_page_controller.dart';
import 'package:aplicativo_furia/app/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:aplicativo_furia/shared/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LivePageController()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = Routes();
    return MaterialApp.router(
      routerConfig: routes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
