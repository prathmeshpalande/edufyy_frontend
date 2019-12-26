import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'config/application.dart';
import 'config/routes/configuration.dart';

class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  AppComponentState() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orangeAccent,
      ),
      onGenerateRoute: Application.router.generator,
    );

    return app;
  }
}

void main() => runApp(AppComponent());
