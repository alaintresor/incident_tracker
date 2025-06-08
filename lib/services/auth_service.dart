import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  static const String baseUrl = 'http://197.243.1.84:3020';
  static const String loginEndpoint = '/users/login';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$loginEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Save user data and token
        await _saveUserData(data);
        
        return {
          'success': true,
          'user': User.fromJson(data['user'] ?? data),
          'token': data['token'] ?? '',
        };
      } else {
        return {
          'success': false,
          'message': 'Invalid email or password',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error. Please try again.',
      };
    }
  }

  Future<void> _saveUserData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', json.encode(data['user'] ?? data));
    await prefs.setString('auth_token', data['token'] ?? '');
    await prefs.setBool('is_logged_in', true);
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    if (userData != null) {
      return User.fromJson(json.decode(userData));
    }
    return null;
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    await prefs.remove('auth_token');
    await prefs.setBool('is_logged_in', false);
  }

  String getProfilePictureUrl() {
    return '$baseUrl/uploads//users/profilePicture-1748607340320-742478406.jpg';
  }
} 