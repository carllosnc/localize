import 'package:flutter/material.dart';
import './localize.dart';

mixin LocalizeMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    localizeState.addListener(action);
  }

  @override
  void dispose() {
    super.dispose();
    localizeState.removeListener(action);
  }

  void action() {
    setState(() {});
  }
}
