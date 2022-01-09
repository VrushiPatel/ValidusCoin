import 'package:ValidusCoin/bloc/main_bloc.dart';
import 'package:ValidusCoin/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BasicScreen<Screen extends StatefulWidget> on State<Screen> {
  late MainBloc bloc;
  late BuildContext baseContext;

  @override
  Widget build(BuildContext context) {
    baseContext = context;
    bloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context);
}
