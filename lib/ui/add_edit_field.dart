import 'package:ValidusCoin/utils/common_widgets.dart';
import 'package:ValidusCoin/utils/custom_colors.dart';
import 'package:ValidusCoin/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEditField extends StatefulWidget {
  final String keyName;

  const AddEditField(this.keyName, {Key? key}) : super(key: key);

  @override
  _AddEditFieldState createState() => _AddEditFieldState();
}

class _AddEditFieldState extends State<AddEditField> {
  TextEditingController controller = TextEditingController();
  SecureStorage storage = SecureStorage();
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  String data = "";

  @override
  void initState() {
    super.initState();
    storage.readValue(widget.keyName).then((value) => setState(() {
          data = value;
          controller.text = data;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(builder: (c) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: formBackgroundColor,
          ),
          margin: EdgeInsets.only(top: 50),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    getEditForm(setTitle(), setMessage(), setHint(), () {
                      if (widget.keyName == SecureStorage.addressKey) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return PlacePicker(
                              apiKey: "AIzaSyB071bKOX6LFWXp4wuczsIS2UQuuNJzaIs",
                              useCurrentLocation: true,
                              selectInitialPosition: true,
                              initialPosition: kInitialPosition,
                              //usePlaceDetailSearch: true,
                              searchingText: controller.text,
                              onPlacePicked: (result) {
                                controller.text =
                                    (result).formattedAddress ?? "";
                                saveData(c);
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                            );
                          },
                        ));
                      }
                    }, () {
                      Navigator.pop(context);
                    }, controller,
                        textInputType: setInputType(),
                        isAddress:
                            (widget.keyName == SecureStorage.addressKey)),
                  ],
                ),
              ),
              getSaveButton("Save", () {
                saveData(c);
              }),
            ],
          ),
        );
      }),
    );
  }

  String setTitle() {
    return widget.keyName == SecureStorage.nameKey
        ? "${data == "" ? "Add" : "Edit"} name"
        : widget.keyName == SecureStorage.emailKey
            ? "${data == "" ? "Add" : "Edit"} email"
            : "${data == "" ? "Add" : "Edit"} Address";
  }

  String setMessage() {
    return widget.keyName == SecureStorage.nameKey
        ? "Please provide your first name and surname"
        : widget.keyName == SecureStorage.emailKey
            ? "We'll send you an email to confirm you new email address"
            : "Please enter your current address";
  }

  String setHint() {
    return widget.keyName == SecureStorage.nameKey
        ? "Full name"
        : widget.keyName == SecureStorage.emailKey
            ? "Email address"
            : "Address";
  }

  void saveData(BuildContext c) {
    if (widget.keyName == SecureStorage.nameKey) {
      storage.setValue(widget.keyName, controller.text);
      Navigator.pop(context);
    } else if (widget.keyName == SecureStorage.emailKey) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(controller.text);

      if (emailValid) {
        storage.setValue(widget.keyName, controller.text);
        Navigator.pop(context);
      } else {
        Scaffold.of(c).showSnackBar(SnackBar(
          content: getSubTitle("Invalid email address!"),
        ));
      }
    } else {
      storage.setValue(widget.keyName, controller.text);
      Navigator.pop(context);
    }
  }

  TextInputType setInputType() {
    return widget.keyName == SecureStorage.nameKey
        ? TextInputType.name
        : widget.keyName == SecureStorage.emailKey
            ? TextInputType.emailAddress
            : TextInputType.text;
  }
}
