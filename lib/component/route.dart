import 'package:flutter/material.dart';
import 'package:dzikirapp/pages/dzikir_counter.dart';
import 'package:dzikirapp/pages/dzikir_detail.dart';
import 'package:dzikirapp/pages/dzikir_custom.dart';
import 'package:dzikirapp/pages/information.dart';
import 'package:dzikirapp/pages/index.dart';

Route createRoute(data, dzikirType) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DzikirCounter(
        timer: data.timer,
        name: data.name,
        qty: data.qty,
        id: data.id,
        dzikirType: dzikirType,
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

Route createRouteToDzikirCustom() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DzikirCustom(),
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

Route createRouteToAppInfo() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AppInformation(),
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

Route createRouteToIndex() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AppIndex(),
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

Route createRouteToDetailDzikir(String dzikirType) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        DzikirDetail(dzikirType: dzikirType),
    transitionDuration: Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      animation = CurvedAnimation(parent: animation, curve: Curves.easeInCubic);
      return FadeTransition(
        opacity: animation,
        // position: animation.drive(tween),
        child: child,
      );
    },
  );
}
