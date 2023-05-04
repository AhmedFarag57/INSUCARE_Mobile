// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insucare/dialog/loading_dialog.dart';
import 'package:insucare/network_utils/api.dart';
import 'package:insucare/screens/auth/signin_screen.dart';
import 'package:insucare/utils/strings.dart';
import 'package:insucare/utils/styles.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    elevation: 5.0,
    padding: const EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  );

  TextEditingController testController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final List<String> _genderItems = [
    'Male',
    'Female',
  ];
  final List<String> _ageRangeItems = [
    'Age 15 and under',
    'Age 16 to 28',
    'Age 29 to 42',
    'Age 43 to 55',
    'Age 56 and over',
  ];
  final List<String> _diabetesTypeItems = [
    'Type 1',
    'Type 2',
    'Gestational',
    'Pre diabetes',
    'Other',
  ];
  final List<String> _therapyTypeItems = [
    'Oral Medication',
    'Daily Injections',
    'Pump Therapy',
    'Other'
  ];

  String _genderSelected = 'Male';
  String _ageRangeSelected = 'Age 15 and under';
  String _diabetesTypeSelected = 'Type 1';
  String _therapyTypeSelected = 'Oral Medication';

  Future _submitInfoApiRequest(BuildContext context) async {
    // ..
    _showLoadingDialog(context);
    var response, body;
    try {
      var data = {
        'gender': _genderSelected,
        'age_range': _ageRangeSelected,
        'diabetes_type': _diabetesTypeSelected,
        'therapy_type': _therapyTypeSelected,
        //'test': testController.text,
        'postal_code': postalCodeController.text,
        'address': addressController.text,
        'phone_number': phoneNumberController.text,
      };
      response = await CallApi().postDataWithToken(data, '/patient/info');
      body = json.decode(response.body);
      if (response.statusCode == 200) {
        // pop the Loading Dialog
        Navigator.of(context).pop();
        // Show success message
        _showSuccessMessage(context, body['message']);
        // Handle the success response
        if (await _handleToGoSigninScreen(context)) {
          Timer(
            const Duration(seconds: 5),
            () {
              // go to Signin Screen
              _goSigninScreen(context);
              // show success message
              _showSuccessMessage(
                context,
                'You must log back in to update your data',
              );
            },
          );
        } else {
          _showErrorMessage(
            context,
            'Error in Logout, You must logout to update your data',
          );
        }
      } else {
        // Throw exception to handle the error
        throw Exception();
      }
    } catch (e) {
      // Handle the error
      // pop the Loading Dialog
      Navigator.of(context).pop();
      // Show the error message
      _showErrorMessage(context, body['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
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
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Add your information'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'You must add your information to complete the registration process.',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildPatientInfoForm(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildPatientInfoForm() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Patient information',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 21.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          _buildGenderDM(),
          const SizedBox(height: 30.0),
          _buildAgeRangeDM(),
          const SizedBox(height: 30.0),
          _buildDiabetesTypeDM(),
          const SizedBox(height: 30.0),
          _buildTherapyTypeDM(),
          const SizedBox(height: 30.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Contact information',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 21.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          _buildTestTF(),
          const SizedBox(height: 30.0),
          _buildPostalCodeTF(),
          const SizedBox(height: 30.0),
          _buildAddressTF(),
          const SizedBox(height: 30.0),
          _buildPhoneNumberTF(),
          const SizedBox(height: 30.0),
          _buildSubmitBtn(),
          _buildHelpBtn(),
        ],
      ),
    );
  }

  Widget _buildGenderDM() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: kLabelStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: SizedBox(
            width: double.maxFinite,
            child: DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFF4780E0),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  _genderSelected == 'male' ? Icons.man : Icons.woman,
                  color: Colors.white,
                ),
              ),
              value: _genderSelected,
              items: _genderItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (item) => setState(() => _genderSelected = item!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAgeRangeDM() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Age Range',
          style: kLabelStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: SizedBox(
            width: double.maxFinite,
            child: DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFF4780E0),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.date_range,
                  color: Colors.white,
                ),
              ),
              value: _ageRangeSelected,
              items: _ageRangeItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (item) => setState(() => _ageRangeSelected = item!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDiabetesTypeDM() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Diabetes type',
          style: kLabelStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: SizedBox(
            width: double.maxFinite,
            child: DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFF4780E0),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              value: _diabetesTypeSelected,
              items: _diabetesTypeItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (item) =>
                  setState(() => _diabetesTypeSelected = item!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTherapyTypeDM() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Therapy type',
          style: kLabelStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: SizedBox(
            width: double.maxFinite,
            child: DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFF4780E0),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              value: _therapyTypeSelected,
              items: _therapyTypeItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (item) => setState(() => _therapyTypeSelected = item!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTestTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Test',
          style: kLabelStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.numbers,
                color: Colors.white,
              ),
              hintText: 'test',
              hintStyle: kHintTextStyle,
              errorBorder: focusErrorBorder,
            ),
            controller: testController,
            validator: (value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPostalCodeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Postal Code',
          style: kLabelStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.numbers,
                color: Colors.white,
              ),
              hintText: 'Postal Code',
              hintStyle: kHintTextStyle,
              errorBorder: focusErrorBorder,
            ),
            controller: postalCodeController,
            validator: (value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddressTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Address',
          style: kLabelStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.streetAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              hintText: 'Enter your address',
              hintStyle: kHintTextStyle,
              errorBorder: focusErrorBorder,
            ),
            controller: addressController,
            validator: (value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Phone Number',
          style: kLabelStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.phone_android,
                color: Colors.white,
              ),
              hintText: 'Enter your phone number',
              hintStyle: kHintTextStyle,
              errorBorder: focusErrorBorder,
            ),
            controller: phoneNumberController,
            validator: (value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 25.0,
      ),
      width: double.infinity,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () async {
          // ...
          if (formKey.currentState!.validate()) {
            _submitInfoApiRequest(context);
          }
        },
        child: const Text(
          'SUBMIT',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildHelpBtn() {
    return GestureDetector(
      onTap: (() {
        /*
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HelpWidget(),
          ),
        );
        */
      }),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Why do we need this information? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Help',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
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

  Future<bool> _handleToGoSigninScreen(BuildContext context) async {
    // Show the loading dialog
    _showLoadingDialog(context);

    // Logout the user
    var response = await CallApi().getDataWithToken('/logout');

    if (response.statusCode == 200) {
      // Delete the user data
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      localStorage.remove('role');
      // Pop the laoding dialog
      Navigator.of(context).pop();
      return true;
    } else {
      // Pop the laoding dialog
      Navigator.of(context).pop();
      return false;
    }
  }

  _goSigninScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return const SigninScreen();
    }), (Route<dynamic> route) => false);
  }
}
