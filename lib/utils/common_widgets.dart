import 'package:ValidusCoin/models/StockResponse.dart';
import 'package:ValidusCoin/utils/custom_colors.dart';
import 'package:ValidusCoin/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var titleFontSize = 26.0;
var bodyFontSize = 14.0;
const colorAccentLight = Colors.black;

Text getTitle(String text, {double? fontSize}) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: fontSize == null ? titleFontSize : fontSize,
    ),
  );
}

Text getSubTitle(String text,
    {bool bold = false,
    bool isCenter = false,
    double? fontSize,
    Color color = Colors.white,
    int? lines,
    String fontFamily = "Airbnb",
    TextDecoration? decoration}) {
  return Text(
    text,
    maxLines: lines,
    textAlign: isCenter ? TextAlign.center : TextAlign.start,
    style: TextStyle(
      color: color,
      fontSize: fontSize == null ? bodyFontSize : fontSize,
      fontWeight: bold ? FontWeight.bold : FontWeight.w400,
      fontFamily: fontFamily,
      decoration: decoration,
    ),
  );
}

Container getStockCard(Datum stock) {
  var dateLastTrade = new DateTime.fromMicrosecondsSinceEpoch(stock.lastTrade!);
  var dateExtendedHours =
      new DateTime.fromMicrosecondsSinceEpoch(stock.extendedHours!);
  DateFormat formatter = DateFormat('HH:mm a');
  return Container(
    height: 220,
    margin: EdgeInsets.all(10),
    color: cardBackgroundColor,
    child: Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 15),
            child: getSubTitle(stock.stockName!, fontSize: 20),
          ),
        ),
        getCardPrice("Price", stock.price!.toString()),
        getCardPrice("Day gain",
            "${stock.lastPrice!.toString()} - ${stock.price!.toString()}"),
        getCardPrice("Last trade", formatter.format(dateLastTrade)),
        getCardPrice("Extended hrs", formatter.format(dateExtendedHours)),
        getCardPrice("% Change", "+ ${stock.dayGain!.toString()} %",
            isPlus: (stock.price! > stock.lastPrice!.toInt())),
      ],
    ),
  );
}

Container getCardPrice(String key, String value, {bool? isPlus}) {
  return Container(
    alignment: Alignment.topLeft,
    child: Container(
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(
        children: [
          getSubTitle(key,
              fontSize: 18, color: cardFontColor, fontFamily: "Grotesk"),
          Expanded(child: SizedBox()),
          Container(
            margin: EdgeInsets.only(top: 5, right: 5),
            child: isPlus != null
                ? isPlus
                    ? Image.asset(
                        upArrow,
                        height: 15,
                        width: 15,
                      )
                    : Image.asset(
                        downArrow,
                        height: 15,
                        width: 15,
                      )
                : Container(),
          ),
          getSubTitle(
            value,
            fontSize: 16,
            fontFamily: "Grotesk",
            color: isPlus == null
                ? Colors.white
                : isPlus
                    ? Colors.green
                    : Colors.red,
          ),
        ],
      ),
    ),
  );
}

Container getBottomNavBar(int page, Function click) {
  return Container(
    child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (page != 1) {
                click();
              }
            },
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        homeImage,
                        height: 22,
                        width: 22,
                        color: page == 2
                            ? bottomBarUnselectedFontColor
                            : bottomBarselectedFontColor,
                      ),
                    ),
                    Container(
                      child: getSubTitle(
                        "Stocks",
                        fontSize: 12,
                        fontFamily: "Grotesk",
                        color: page == 2
                            ? bottomBarUnselectedFontColor
                            : bottomBarselectedFontColor,
                      ),
                      margin: EdgeInsets.only(top: 5, bottom: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (page != 2) {
                click();
              }
            },
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        profileImage,
                        height: 22,
                        width: 22,
                        color: page == 1
                            ? bottomBarUnselectedFontColor
                            : bottomBarselectedFontColor,
                      ),
                    ),
                    Container(
                      child: getSubTitle(
                        "Profile",
                        fontSize: 12,
                        fontFamily: "Grotesk",
                        color: page == 1
                            ? bottomBarUnselectedFontColor
                            : bottomBarselectedFontColor,
                      ),
                      margin: EdgeInsets.only(top: 5, bottom: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Container getFormPart(String title, Function onClick, String value) {
  return Container(
    height: value == "" ? 65 : 100,
    child: Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: getSubTitle(title,
                  color: cardFontColor, fontSize: 16, fontFamily: "Thin"),
            ),
            Expanded(child: Container()),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                onClick();
              },
              child: Container(
                child: getSubTitle(
                  value == "" ? "Add" : "Edit",
                  color: cardFontColor,
                  fontSize: 18,
                  fontFamily: "Thin",
                  decoration: TextDecoration.underline,
                ),
                margin: EdgeInsets.only(right: 20, top: 5),
              ),
            ),
          ],
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            onClick();
          },
          child: Container(
            margin: EdgeInsets.only(top: 10, left: 20),
            alignment: Alignment.topLeft,
            child: getSubTitle(
              value,
              color: formFontColor,
              fontSize: 20,
              fontFamily: "Thin",
            ),
          ),
        )
      ],
    ),
  );
}

Container getEditForm(String title, String message, String hint,
    Function onSubmit, Function close, TextEditingController controller,
    {TextInputType textInputType = TextInputType.name,
    bool isAddress = false}) {
  return Container(
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(30),
          child: Row(
            children: [
              GestureDetector(
                child: Image.asset(closeImage),
                onTap: () {
                  close();
                },
              ),
              Expanded(
                child: SizedBox(),
              ),
              getTitle(
                title,
                fontSize: 18,
              ),
              Expanded(
                child: SizedBox(),
              ),
              Opacity(
                child: Image.asset(homeImage),
                opacity: 0,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 25, left: 20),
          alignment: Alignment.topLeft,
          child: getSubTitle(message,
              fontFamily: "Thin", fontSize: 17, isCenter: true),
        ),
        Container(
          margin: EdgeInsets.only(top: 25, left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
            color: editFieldsBackgroundColor,
          ),
          child: Column(
            children: [
              Container(
                child: getSubTitle(hint,
                    fontFamily: "Thin",
                    fontSize: 16,
                    color: editFieldsHintColor),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 10, left: 15),
              ),
              GestureDetector(
                onTap: () {
                  if (isAddress) {
                    onSubmit();
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10, top: 5),
                  child: TextField(
                    enabled: !isAddress,
                    onSubmitted: (v) {
                      onSubmit();
                    },
                    controller: controller,
                    expands: false,
                    keyboardType: textInputType,
                    style:
                        TextStyle(color: cardFontColor, fontFamily: "Grotesk"),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget getSaveButton(String title, Function onClick) {
  return InkWell(
    onTap: () {
      onClick();
    },
    child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              onClick();
            },
            style: ElevatedButton.styleFrom(primary: buttonBackgroundColor),
            child: getSubTitle(title,
                fontSize: 20, fontFamily: "Grotesk", color: Colors.black))),
  );
}
