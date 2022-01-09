import 'package:ValidusCoin/base/base_screen.dart';
import 'package:ValidusCoin/bloc/main_bloc.dart';
import 'package:ValidusCoin/utils/common_widgets.dart';
import 'package:ValidusCoin/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:ValidusCoin/utils/secure_storage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with BasicScreen {
  SecureStorage storage = SecureStorage();

  String name = "";
  String email = "";
  String address = "";

  @override
  void initState() {
    super.initState();
    getSecuredData();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
          child: getTitle("Profile", fontSize: 30),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                    color: cardBackgroundColor,
                    padding: EdgeInsets.only(top: 50),
                    child: getFormPart("Name", () {
                      bloc.add(
                          AddEditProfile(SecureStorage.nameKey, context, () {
                        getSecuredData();
                      }));
                    }, name)),
                Container(
                    color: cardBackgroundColor,
                    padding: EdgeInsets.only(top: 10),
                    child: getFormPart("Email", () {
                      bloc.add(
                          AddEditProfile(SecureStorage.emailKey, context, () {
                        getSecuredData();
                      }));
                    }, email)),
                Container(
                    color: cardBackgroundColor,
                    padding: EdgeInsets.only(top: 10),
                    child: getFormPart("Address", () {
                      bloc.add(
                          AddEditProfile(SecureStorage.addressKey, context, () {
                        getSecuredData();
                      }));
                    }, address)),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 0, left: 0, bottom: 0),
          child: getBottomNavBar(2, () {
            bloc.add(WelcomeIn());
          }),
        ),
      ],
    );
  }

  getSecuredData() {
    storage.readValue(SecureStorage.nameKey).then((value) {
      if (mounted) {
        setState(() {
          name = value;
        });
      }
    });
    storage.readValue(SecureStorage.emailKey).then((value) {
      if (mounted) {
        setState(() {
          email = value;
        });
      }
    });
    storage.readValue(SecureStorage.addressKey).then((value) {
      if (mounted) {
        setState(() {
          address = value;
        });
      }
    });
  }
}
