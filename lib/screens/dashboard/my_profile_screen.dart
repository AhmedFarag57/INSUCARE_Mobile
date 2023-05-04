// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:insucare/dialog/loading_dialog.dart';
import 'package:insucare/network_utils/api.dart';
import 'package:insucare/screens/auth/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    elevation: 5.0,
    padding: const EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  );

  // ignore: unused_element
  Future<void> _logoutRequest(BuildContext context) async {
    // Show the Loading dialog
    _showLoadingDialog(context);
    try {
      var response = await CallApi().getDataWithToken('/logout');
      if (response.statusCode == 200) {
        // Remove from the device all user data
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.remove('user');
        localStorage.remove('token');
        localStorage.remove('role');
        var body = json.decode(response.body);
        // Pop the loading dialog
        Navigator.of(context).pop();
        // Go to Signin screen
        _goSignInScreen(context);
        // Show success message
        _showSuccessMessage(context, body['message']);
      } else {
        // Throw exception to handle the error
        throw Exception();
      }
    } catch (e) {
      // Pop the Loading dialog
      Navigator.of(context).pop();
      // Show error message
      _showErrorMessage(context, 'Error in logout. Please try again');
    }
  }

  Future<void> _fakeLogout(BuildContext context) async {
    // Show the Loading dialog
    _showLoadingDialog(context);
    Timer(const Duration(seconds: 2), () {
      _goSignInScreen(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF4780E0),
                  Color(0xFF398AE5),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          // ignore: sized_box_for_whitespace
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 100.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  _buildActionBtn('My Account', Icons.person, () {
                    // ..
                  }),
                  _buildActionBtn('Logout', Icons.logout_sharp, () {
                    //_logoutRequest(context);
                    _fakeLogout(context);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String text, IconData icon, VoidCallback func) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: func,
        style: raisedButtonStyle,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showLoadingDialog(BuildContext context) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => const LoadingDialog(),
        )) ??
        false;
  }

  _showSuccessMessage(BuildContext context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: 'Success',
          message: message,
          contentType: ContentType.success,
        ),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  _showErrorMessage(BuildContext context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: 'Oh Snap!',
          message: message,
          contentType: ContentType.failure,
        ),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  _goSignInScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return const SigninScreen();
    }), (Route<dynamic> route) => false);
  }
}
