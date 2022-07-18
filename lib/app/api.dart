import 'dart:convert';
import 'package:lotus_trading_company_sivakasi/models/api_responce_model.dart';
import 'package:lotus_trading_company_sivakasi/models/category_model.dart';
import 'package:lotus_trading_company_sivakasi/models/product_model.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String _baseUrl = 'https://2908f9ba-3645-489a-984e-085d03d116a1.mock.pstmn.io';

  static Future<User> signupUser(
    String email,
    String phone,
    String password,
  ) async {
    var signupUrl = Uri.parse(_baseUrl + '/user');
    try {
      http.Response responce = await http.post(
        signupUrl,
        body: {
          "email": email,
          "phone": phone,
          "password": password,
        },
      );
      Map<String, dynamic> json = jsonDecode(responce.body);
      User user =
          ApiResponce<User>.fromJson(json, User.fromJson(json['data'])).data!;
      return user;
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future<User> loginUser(
    String email,
    String password,
  ) async {
    var signinUrl = Uri.parse(_baseUrl + '/user/signin');
    try {
      http.Response responce = await http.post(
        signinUrl,
        body: {
          "email": email,
          "password": password,
        },
      );
      Map<String, dynamic> json = jsonDecode(responce.body);
      User user =
          ApiResponce<User>.fromJson(json, User.fromJson(json['data'])).data!;
      return user;
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future<User> logoutUser(
    String? accessToken,
  ) async {
    var signoutUrl = Uri.parse(_baseUrl + '/user/signout');
    try {
      http.Response responce = await http.get(
        signoutUrl,
        headers: {"Authorization": "Bearer ${accessToken.toString()}"},
      );
      Map<String, dynamic> json = jsonDecode(responce.body);
      User user =
          ApiResponce<User>.fromJson(json, User.fromJson(json['data'])).data!;
      return user;
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future<List<Category>> getCategories(String? accessToken) async {
    var categoryUrl = Uri.parse(_baseUrl + '/category');
    try {
      print("getCategories");
      http.Response responce = await http.get(categoryUrl,
          headers: {"Authorization": "Bearer ${accessToken.toString()}"});
      print(responce.body);
      List<dynamic> json = jsonDecode(responce.body)["data"];
      List<Category> categories =
          json.map((object) => Category.fromJson(object)).toList();
      return categories;
    } catch (e) {
      print( "getCateogry: "  + e.toString());
      throw (e.toString());
    }
  }

  static Future<List<Product>> getProducts(String? accessToken) async {
    var productUrl = Uri.parse(_baseUrl + '/product');
    try {
      http.Response responce = await http.get(productUrl,
          headers: {"Authorization": "Bearer ${accessToken.toString()}"});
      print(responce.body);
      List<dynamic> json = jsonDecode(responce.body)["data"];
      List<Product> products =
          json.map((object) => Product.fromJson(object)).toList();
      return products;
    } catch (e) {
      print( "getProducts: "  + e.toString());
      throw (e.toString());
    }
  }

  static Future<List<Product>> getProductsByCategory(
      String? accessToken, int categoryId) async {
    var productUrl = Uri.parse(_baseUrl + '/product/${categoryId.toString()}');
    try {
      http.Response responce = await http.get(productUrl,
          headers: {"Authorization": "Bearer ${accessToken.toString()}"});
      print(responce.body);
      List<dynamic> json = jsonDecode(responce.body)["data"];
      List<Product> products =
          json.map((object) => Product.fromJson(object)).toList();
      return products;
    } catch (e) {
      print( "getProductsByCategory: "  + e.toString());
      throw (e.toString());
    }
  }

  static Future<List<Product>> getProductsByTitle(
      String? accessToken, String text) async {
    var productUrl =
        Uri.parse(_baseUrl + '/product/search?q=${text.toString()}');
    try {
      http.Response responce = await http.get(productUrl,
          headers: {"Authorization": "Bearer ${accessToken.toString()}"});
      print(responce.body);
      List<dynamic> json = jsonDecode(responce.body)["data"];
      List<Product> products =
          json.map((object) => Product.fromJson(object)).toList();
      return products;
    } catch (e) {
      print( "getProductsByTitle: "  + e.toString());
      throw (e.toString());
    }
  }

  static Future<int> placeOrder(
      String? accessToken,
      String name,
      String email,
      String phno,
      String address,
      String zip,
      String city,
      String country,
      List<Map<String, dynamic>> items) async {
    var orderUrl = Uri.parse(_baseUrl + '/order');
    try {
      http.Response responce = await http.post(
        orderUrl,
        headers: {
          "Authorization": "Bearer ${accessToken.toString()}",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "phoneNumber": phno,
          "address": address,
          "zip": zip,
          "city": city,
          "country": country,
          "items": items,
        }),
      );
      Map<String, dynamic> json = jsonDecode(responce.body)["data"];
      int id = json["id"];
      return id;
    } catch (e) {
      throw (e.toString());
    }
  }
}
