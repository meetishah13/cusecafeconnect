import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'package:cuse_cafe_connect/controller/UserController.dart';
import 'package:cuse_cafe_connect/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileView extends StatefulWidget {
  ProfileView();

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final UserController uc = UserController();
  UserModel? _userDetails;
  bool _isEditing = false;
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _suIDController;
  final ImagePicker _picker = ImagePicker();
  late File _selectedImageFile;
  String _localProfileImagePath = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    _suIDController = TextEditingController();
    _emailController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _selectedImageFile = File('');
  }

  @override
  void dispose() {
    _suIDController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserDetails() async {
    final userDetails = await uc.getProfileDetails();
    String userId = userDetails?.userID.toString() ?? '';
    String defaultProfileImagePath = 'assets/user.png';

    // Check if the user has a profile image in Firebase Storage
    String imageUrl = '';
    try {
      imageUrl = await firebase_storage.FirebaseStorage.instance
          .ref('profile_images/$userId.jpg')
          .getDownloadURL();
    } catch (error) {
      print('Profile image not found in Firebase Storage');
    }

    setState(() {
      _userDetails = userDetails;
      _suIDController.text = userDetails?.userID.toString() ?? '';
      _emailController.text = userDetails?.userEmail ?? '';
      _firstNameController.text = userDetails?.fName ?? '';
      _lastNameController.text = userDetails?.lName ?? '';
      _phoneNumberController.text = userDetails?.phoneNo ?? '';
      _localProfileImagePath =
          imageUrl.isNotEmpty ? imageUrl : defaultProfileImagePath;
    });
  }

  Future<void> _selectImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImageFile = File(pickedFile.path);
      });

      Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${_userDetails!.userID}.jpg');

      // Display a loading indicator
      showDialog(
        context: context,
        barrierDismissible:
            false, // Prevent dismissing the dialog by tapping outside
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        await ref.putFile(_selectedImageFile);
        imageUrl = await ref.getDownloadURL();

        // Close the loading indicator dialog
        Navigator.of(context).pop();

        // Refresh the page after uploading the image
        await _fetchUserDetails();
      } catch (error) {
        print("Firebase upload failed");
        // Close the loading indicator dialog
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isEditing = false;
    });

    bool isUpdated = await uc.updateProfileDetails(
      _userDetails?.userID ?? 0,
      _emailController.text,
      _firstNameController.text,
      _lastNameController.text,
      _phoneNumberController.text,
      _selectedImageFile,
    );

    if (isUpdated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Details updated successfully'),
        ),
      );

      // Fetch updated user details after saving changes
      await _fetchUserDetails();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'There was an error updating details. Please try again later.'),
        ),
      );
    }
  }

  Widget _buildImagePicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () => _showImageSourceDialog(),
            child: Text('Change Profile'),
          ),
        ),
      ],
    );
  }

  Future<void> _showImageSourceDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () {
                    _selectImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    _selectImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailItem(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: !_isEditing,
              decoration: InputDecoration(labelText: title),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    print("Hello fp: " + _selectedImageFile.toString());
    if (_localProfileImagePath.startsWith('http')) {
      // If the image path is a URL, load it as a network image
      return Container(
        width: 175,
        height: 175,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: ClipOval(
          child: Image.network(
            _localProfileImagePath,
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      // If the image path is a local asset, load it as an asset image
      return Container(
        width: 175,
        height: 175,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: ClipOval(
          child: Image.asset(
            _localProfileImagePath,
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: _isEditing
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: _saveChanges,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF76900),
                      ),
                      child: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF76900),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
      ),
      body: _userDetails == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildProfileImage(),
                        ],
                      ),
                      _buildDetailItem('My Email', _emailController),
                      _buildDetailItem('First Name', _firstNameController),
                      _buildDetailItem('Last Name', _lastNameController),
                      _buildDetailItem('Phone Number', _phoneNumberController),
                      SizedBox(height: 20),
                      if (_isEditing) _buildImagePicker(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
