import 'dart:convert';
import 'dart:io';
import 'package:cuse_cafe_connect/model/UserModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<UserModel?> loginUser(String username, String password) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String? deviceType = _pref.getString('platform');
    String localhost = (deviceType == 'ios') ? 'localhost' : '10.0.2.2';
    try {
      final response = await http.get(
        Uri.parse(
            'http://$localhost:8080/api/users/login?emailId=$username&password=$password'),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success']) {
          UserModel user = UserModel.fromJson(responseData['user']);
          return user;
        } else {
          return null;
        }
      } else {
        print('HTTP Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }

  Future<UserModel?> getProfileDetails(int userId) async {
    print(userId.toString());
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String? deviceType = _pref.getString('platform');
    String localhost = (deviceType == 'ios') ? 'localhost' : '10.0.2.2';
    final url =
        Uri.parse('http://$localhost:8080/api/users/$userId/getUserDetails');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return UserModel.fromJson(jsonData);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle exception
      print('Error: $e');
      return null;
    }
  }

  Future<bool> updateUserDetails(
    int userID,
    String email,
    String fName,
    String lName,
    String phoneNo,
    File? photoPath,
  ) async {
    try {
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      String? deviceType = _pref.getString('platform');
      String localhost = (deviceType == 'ios') ? 'localhost' : '10.0.2.2';
      var uri = Uri.parse('http://$localhost:8080/api/users/editUser');

      var request = http.MultipartRequest('PUT', uri)
        ..fields['userID'] = userID.toString()
        ..fields['userEmail'] = email
        ..fields['fName'] = fName
        ..fields['lName'] = lName
        ..fields['phoneNo'] = phoneNo;

      // // Add photoPath if provided
      // if (photoPath != null) {
      //   // Convert image file to bytes
      //   List<int> imageBytes = await photoPath.readAsBytes();
      //   // Create multipart file from bytes
      //   var multipartFile = http.MultipartFile.fromBytes(
      //     'photoPath',
      //     imageBytes,
      //     filename: 'user_photo.jpg', // Provide a filename for the image
      //   );
      //   // Add multipart file to request
      //   request.files.add(multipartFile);
      // }

      // Send the request
      var response = await request.send();

      // Check the response status code
      if (response.statusCode == 200) {
        print('User details updated successfully');
        return true;
      } else {
        print(
            'Failed to update user details. Status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error updating user details: $error');
      return false;
    }
  }

  Future<bool> signupUser(String suid, String firstName, String lastName,
      String email, String password, String phoneNumber) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String? deviceType = _pref.getString('platform');
    String localhost = (deviceType == 'ios') ? 'localhost' : '10.0.2.2';
    String url = 'http://$localhost:8080/api/users/addUser';
    Map<String, dynamic> requestBody = {
      'userID': suid,
      'userEmail': email,
      'fName': firstName,
      'lName': lastName,
      'password': password,
      'phoneNo': phoneNumber,
      'roleID': 3,
      'cafeID': 0
    };
    String jsonBody = json.encode(requestBody);
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );
      if (response.statusCode == 201) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        if (responseData['userID'] != null) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
