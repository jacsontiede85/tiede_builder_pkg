import 'package:flutter/material.dart';
import 'package:tiede_builder_pkg/tiede_notify.dart';

class TiedeBuilder extends StatefulWidget {
  const TiedeBuilder({super.key, required this.notify, required this.builder});
  final TiedeNotify notify;
  final Widget Function(BuildContext context) builder;

  @override
  State<TiedeBuilder> createState() => _TiedeBuilderState();
}


class _TiedeBuilderState extends State<TiedeBuilder> {

  @override
  void initState() {
    widget.notify.addListener(_listerner);
    super.initState();
  }

  _listerner() => setState(() {});

  @override
  void dispose() {
    widget.notify.removeListener(_listerner);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) => widget.builder(context);
  
}