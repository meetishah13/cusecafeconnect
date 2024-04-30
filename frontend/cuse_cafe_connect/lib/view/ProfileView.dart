import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cuse_cafe_connect/controller/UserController.dart';
import 'package:cuse_cafe_connect/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  late Uint8List bytes;
  String imagePath = '';
  late File _selectedImageFile;

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
    setState(() {
      _userDetails = userDetails;
      _suIDController.text = userDetails?.userID.toString() ?? '';
      _emailController.text = userDetails?.userEmail ?? '';
      _firstNameController.text = userDetails?.fName ?? '';
      _lastNameController.text = userDetails?.lName ?? '';
      _phoneNumberController.text = userDetails?.phoneNo ?? '';
      imagePath = userDetails?.photoPath ?? '';
      bytes = base64Decode(imagePath);
    });
  }

  Future<void> _selectImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImageFile = File(pickedFile.path);
      });
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'There was an error updating details. Please try again later.'),
        ),
      );
    }
    _fetchUserDetails();
  }

  Widget _buildImagePicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => _showImageSourceDialog(),
          child: Text('Change Profile'),
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

  Widget _buildCircularImage(Uint8List bytes) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black, // Change color as needed
          width: 4, // Adjust the thickness of the border
        ),
      ),
      child: ClipOval(
        child: Image.memory(
          bytes,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        actions: _isEditing
            ? [
          IconButton(
            onPressed: _saveChanges,
            icon: Icon(Icons.save),
          ),
        ]
            : [
          IconButton(
            onPressed: () {
              setState(() {
                _isEditing = true;
              });
            },
            icon: Icon(Icons.edit),
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
                _buildDetailItem('User Email', _emailController),
                _buildDetailItem('First Name', _firstNameController),
                _buildDetailItem('Last Name', _lastNameController),
                _buildDetailItem('Phone Number', _phoneNumberController),
                SizedBox(height: 20),
                if (_isEditing) _buildImagePicker(),
                if (imagePath != '' && !_isEditing)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCircularImage(bytes),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}