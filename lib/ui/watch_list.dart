import 'package:ValidusCoin/base/base_screen.dart';
import 'package:ValidusCoin/bloc/main_bloc.dart';
import 'package:ValidusCoin/utils/common_widgets.dart';
import 'package:flutter/material.dart';

class WatchList extends StatefulWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> with BasicScreen {
  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
          child: getTitle("My watchlist", fontSize: 30),
        ),
        Expanded(
          child: ListView(
            children: bloc.data.data!.map<Widget>((stock) {
              return getStockCard(stock);
            }).toList(),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 0, left: 0, bottom: 0),
          child: getBottomNavBar(1, () {
            bloc.add(ShowProfile());
          }),
        ),
      ],
    );
  }
}
