import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      print("Request data :- ${data.toString()}");
      return data;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("Response data :- ${data.toString()}");
    return data;
  }
}
