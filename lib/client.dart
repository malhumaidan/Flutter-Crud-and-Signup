import 'package:dio/dio.dart';

class Client {
  static final Dio dioCrud =
      Dio(BaseOptions(baseUrl: "https://coded-pets-api-crud.herokuapp.com"));
  static final Dio dioAuth =
      Dio(BaseOptions(baseUrl: "https://coded-pets-api-auth.herokuapp.com"));
}
