import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insucare/dialog/loading_dialog.dart';

class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  int _widgetSelected = 0;

  Future _saveTheChanges() async {
    // Pop the Alert Dialog
    Navigator.of(context).pop(true);

    // Show the Loading dialog
    _showLoadingDialog(context);

    await Future.delayed(
      const Duration(milliseconds: 3000),
      () {
        print('done');
      },
    );

    // Pop the Loading dialog
    Navigator.of(context).pop(true);

    // pop the Programs screen
    Navigator.of(context).pop(true);
    return;
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Saving changes'),
              content: const Text(
                'Do you want to save your changes and go back?',
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        onPressed: () async {
                          await _saveTheChanges();
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                child: _buildBodyWidget(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildPageTitle(),
        const SizedBox(height: 50.0),
        _buildCategorysSection(),
        const SizedBox(height: 30.0),
        _buildContentView(context),
      ],
    );
  }

  Widget _buildPageTitle() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _onWillPop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 32.0,
          ),
        ),
        const SizedBox(width: 36.0),
        const Text(
          'P R O G R A M S',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        )
      ],
    );
  }

  Widget _buildCategorysSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCategoryWidget(Icons.work_rounded, 'Work', 0),
        _buildCategoryWidget(Icons.sunny_snowing, 'Rest day', 1),
        _buildCategoryWidget(Icons.no_food_rounded, 'Fasting', 2),
      ],
    );
  }

  Widget _buildCategoryWidget(icon, text, index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _widgetSelected = index;
        });
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: _widgetSelected == index
                  ? Colors.indigoAccent[700]
                  : Colors.indigo[900],
              size: 48.0,
            ),
            const SizedBox(height: 12.0),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _widgetSelected == index
                    ? Colors.indigoAccent[700]
                    : Colors.indigo[900],
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentView(BuildContext context) {
    if (_widgetSelected == 0) {
      return _buildWorkingContentView(context);
    } else if (_widgetSelected == 1) {
      return _buildRestContentView(context);
    } else {
      return _buildFastingContentView(context);
    }
  }

  Widget _buildWorkingContentView(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 50.0,
        right: 15.0,
        left: 15.0,
      ),
      child: Column(
        children: [
          // ..
          Text('Work'),
        ],
      ),
    );
  }

  Widget _buildRestContentView(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 50.0,
        right: 15.0,
        left: 15.0,
      ),
      child: Column(
        children: [
          // ..
          Text('rest day'),
        ],
      ),
    );
  }

  Widget _buildFastingContentView(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 50.0,
        right: 15.0,
        left: 15.0,
      ),
      child: Column(
        children: [
          // ..
          Text('Fasting'),
        ],
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
}
