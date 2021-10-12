import 'package:flutter/material.dart';
import 'package:dzikirapp/pages/dzikir_counter.dart';
import 'package:dzikirapp/pages/home.dart';

Route createRoute(data) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => StackOver(
        timer: data.timer,
        name: data.name,
        qty: data.qty,
        id: data.id,
        lastCount: data.lastcount),
    transitionDuration: Duration(milliseconds: 1000),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      animation = CurvedAnimation(parent: animation, curve: Curves.ease);
      return FadeTransition(
        opacity: animation,
        // position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route createRouteToHome(data) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AppHome(),
    transitionDuration: Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      animation = CurvedAnimation(parent: animation, curve: Curves.ease);
      return FadeTransition(
        opacity: animation,
        // position: animation.drive(tween),
        child: child,
      );
    },
  );
}
