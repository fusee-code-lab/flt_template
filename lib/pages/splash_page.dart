import 'package:flt_template/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          const Text("Ting Mobile")
              .textStyle(Theme.of(context).textTheme.titleLarge!),
          TextButton(
            onPressed: () {
              const HomeRoute().pushReplacement(context);
            },
            child: Text("Go To Home"),
          ),
        ],
      ).width(double.infinity),
    );
  }
}
