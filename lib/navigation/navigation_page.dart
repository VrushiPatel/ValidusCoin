import 'package:ValidusCoin/base/base_screen.dart';
import 'package:ValidusCoin/bloc/main_bloc.dart';
import 'package:ValidusCoin/ui/profile.dart';
import 'package:ValidusCoin/ui/watch_list.dart';
import 'package:ValidusCoin/utils/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> with BasicScreen {
  // Will be initialized later
  late MainBloc bloc;

  @override
  Widget buildBody(BuildContext context) {
    // initial state is set here
    bloc = BlocProvider.of<MainBloc>(context);
    bloc.init();
    return WillPopScope(
      child: BlocBuilder<MainBloc, MainStates>(
        builder: (context, state) {
          if (state == MainStates.Home) {
            return WatchList();
          } else if (state == MainStates.Profile) {
            return Profile();
          } else if (state == MainStates.LoggedLOADING) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  getSubTitle("Loading..."),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: CircularProgressIndicator()),
                ],
              ),
            );
          } else if (state == MainStates.Error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  getSubTitle("${bloc.data.message}"),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
