import 'dart:convert';
import 'dart:io';

import 'package:ValidusCoin/http_interceptors/LoggingInterceptor.dart';
import 'package:ValidusCoin/models/StockResponse.dart';
import 'package:http_interceptor/http/http.dart';

class DataRepository {
  String baseUrl = "run.mocky.io";

  DataRepository();

  static DataRepository getInstance() {
    return DataRepository();
  }

  Future<StockResponse> getData() async {
    try {
      final result = await InternetAddress.lookup(baseUrl);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return InterceptedClient.build(interceptors: [LoggingInterceptor()])
            .get(Uri.https(baseUrl, "v3/fc3ddccf-855c-4bb6-861c-cf7896aa963e"))
            .timeout(const Duration(seconds: 60))
            .then((value) {
          try {
            return StockResponse.fromJson(json.decode(value.body));
          } on SocketException {
            return StockResponse(false, message: 'No Internet connection');
          } on FormatException {
            return StockResponse(false, message: 'Bad response format');
          } on Exception {
            return StockResponse(false, message: 'Unexpected error');
          } /*catch (e) {
            return StockResponse(false, message: 'Something went wrong');
          }*/
        });
      } else {
        return StockResponse(false, message: 'Something went wrong');
      }
    } on SocketException catch (_) {
      return StockResponse(false, message: 'No Internet connection');
    }
  }
}
