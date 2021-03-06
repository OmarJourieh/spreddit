import 'dart:convert';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import '../constants/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class AuthsProvider extends ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String userId;
  Timer _authTimer;
  Auth user;
  User user1;
  bool showProfile = true;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> register(Auth auth) async {
    // http.Response res = await http.post(
    //   Uri.parse(API + "/auth/register"),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(auth),
    // );
    // print(res.body);
    // notifyListeners();

    try {
      http.Response res = await http.post(
        Uri.parse(API + "/auth/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(auth),
      );
      if (jsonDecode(res.body)['errNum'] != null) {
        throw HttpException(jsonDecode(res.body)['msg']);
      }
      // this.login(auth);
    } catch (e) {
      throw e;
    }
  }

  Future<void> login(Auth auth) async {
    try {
      print("Trying login!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      http.Response res = await http.post(
        Uri.parse(API + "/auth/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(auth),
      );

      if (jsonDecode(res.body)['errNum'] != null) {
        print(jsonDecode(res.body)['msg']);
        print("FAILED login!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        throw HttpException(jsonDecode(res.body)['msg']);
      }
      String data = res.body;
      var jsonData = jsonDecode(data);
      _token = jsonData['token'];
      //_userId = responseDate['localId'];
      _expiryDate = DateTime.now().add(Duration(seconds: int.parse('10000')));
      _autologout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      String userDate = json.encode({
        'token': _token,
        //'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String()
      });
      prefs.setString('userDate', userDate);

      //-------------------------------
      http.Response res2 = await http.get(
        Uri.parse(API + "/auth/profile"),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      user = Auth.fromJson(jsonDecode(res2.body)['user']);
      // showProfile = user.showProfile;
      user1 = User.fromJson(jsonDecode(res2.body)['user']);
    } catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutologin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userDate')) return false;
    final Map<String, Object> extractedDate =
        json.decode(prefs.getString('userDate')) as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedDate['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) return false;

    _token = extractedDate['token'];
    //_userId = extractedDate['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autologout();
    return true;
  }

  Future<void> logout() async {
    print("logout");
    _token = null;
    userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autologout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('token');
  }

  Future<Auth> getUser() async {
    if (token != null) {
      http.Response res = await http.get(
        Uri.parse(API + "/auth/profile"),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      userId = (Auth.fromJson(jsonDecode(res.body)['user']).id).toString();

      return Auth.fromJson(jsonDecode(res.body)['user']);
    }
  }

  Future<void> updateUser(Auth user) async {
    http.MultipartRequest request = http.MultipartRequest(
        "POST", Uri.parse("$API/updatedatauser/${user.id}"));

    if (user.imageToSend != 'null') {
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('image', user.imageToSend);
      request.files.add(multipartFile);
    }

    request.fields['name'] = user.username;
    request.fields['email'] = user.email;
    request.fields['address'] = user.address;
    request.fields['phone'] = user.phone;

    http.StreamedResponse response = await request.send();

    http.Response res = await http.post(
      Uri.parse(API + "/auth/update"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(user),
    );
    print(res.body);
    notifyListeners();
  }

  Future<User> getUserById(int userId) async {
    var res = await http.get(
      Uri.parse(API + '/getuserbyid/' + userId.toString()),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    // product = Product.fromJson(jsonDecode(res.body));
    // notifyListeners();
    return User.fromJson(jsonDecode(res.body));
  }

  Future<String> getUserRate(int userId) async {
    var res = await http.get(
      Uri.parse(API + '/getaveragerate/' + userId.toString()),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    return res.body;
  }

  Future<void> rateUser(int raterId, int ratedId, int rate) async {
    var res = await http.get(
      Uri.parse(API + '/rateuser/$raterId/$ratedId/$rate'),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
  }

  Future<String> hasRated(int raterId, int ratedId) async {
    var res = await http.get(
      Uri.parse(API + '/hasRated/$raterId/$ratedId'),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    print(res.body);
    return res.body;
  }

  Future<void> hideShowProfile(int userId) async {
    var res = await http.get(
      Uri.parse(API + '/hideShowProfile/$userId'),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    user = Auth.fromJson(jsonDecode(res.body));
    print("UPDATED USER ${user.showProfile}");
    print("UPDATED USER ${user.showProfile}");
    print("UPDATED USER ${user.showProfile}");
    print("UPDATED USER ${user.showProfile}");
    print("UPDATED USER ${user.showProfile}");
    print("UPDATED USER ${user.showProfile}");
    print("UPDATED USER ${user.showProfile}");
    print("UPDATED USER ${user.showProfile}");
    print("UPDATED USER ${user.showProfile}");
    print("UPDATED USER ${user.showProfile}");
    print("UPDATED USER ${user.showProfile}");
    // showProfile = user.showProfile;
    user1 = User.fromJson(jsonDecode(res.body));
    print(res.body);
  }
}
