import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insucare/screens/dashboard/my_profile_screen.dart';
import 'package:insucare/screens/dashboard/patient_home_screen.dart';
import 'package:insucare/screens/dashboard/user_home_screen.dart';
import 'package:insucare/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.device});

  final BluetoothDevice? device;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  bool _isLoading = true;

  var role;

  @override
  void initState() {
    super.initState();
    _loadDataFromDevice();
    setState(() {
      _isLoading = false;
    });
  }

  Future _loadDataFromDevice() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    role = jsonDecode(localStorage.getString('role')!);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: const [
            Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: goToScreen(currentIndex),
        backgroundColor: Colors.white,
        bottomNavigationBar: Material(
          elevation: 10,
          child: BottomNavigationBar(
            elevation: 25,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: _onTapIndex,
            items: role['name'] == 'User'
                ? [
                    BottomNavigationBarItem(
                      label: "Home",
                      icon: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: currentIndex == 0
                              ? CustomColor.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/svg/home.svg',
                            color:
                                currentIndex == 0 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Profile",
                      icon: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: currentIndex == 1
                                ? CustomColor.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/svg/profile.svg',
                            color:
                                currentIndex == 1 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ]
                : [
                    BottomNavigationBarItem(
                      label: "Home",
                      icon: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: currentIndex == 0
                              ? CustomColor.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/svg/home.svg',
                            color:
                                currentIndex == 0 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Profile",
                      icon: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: currentIndex == 1
                                ? CustomColor.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/svg/profile.svg',
                            color:
                                currentIndex == 1 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
          ),
        ),
      );
    }
  }

  _onTapIndex(index) {
    setState(() {
      currentIndex = index;
    });
    goToScreen(currentIndex);
  }

  goToScreen(int currentIndex) {
    if (role['name'] == 'User') {
      switch (currentIndex) {
        case 0:
          return UserHomeScreen();
        case 1:
          return ProfileScreen();
      }
    } else if (role['name'] == 'Patient') {
      switch (currentIndex) {
        case 0:
          return PatientHomeScreen(device: widget.device);
        case 1:
          return ProfileScreen();
      }
    }
  }
}
