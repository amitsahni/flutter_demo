// 1
import 'dart:async';

import 'package:f_d/src/data/model/data_result.dart';
import 'package:flutter/material.dart';


abstract class Bloc {
  void initState();
  void dispose();

  final errorController = StreamController<Failure>.broadcast();

  Stream<Failure> get errorStream => errorController.stream;
}

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key? key, required this.bloc, required this.child})
      : super(key: key);

  // 2
  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T>? provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider!.bloc;
  }

  @override
  State createState() => _BlocProviderState();

}

class _BlocProviderState extends State<BlocProvider> {

  @override
  void initState() {
    widget.bloc.initState();
    super.initState();
  }

  // 4
  @override
  Widget build(BuildContext context) => widget.child;

  // 5
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
