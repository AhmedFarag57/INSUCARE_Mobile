import 'package:flutter/material.dart';
import 'package:insucare/dialog/custom_dialog.dart';

class CarbCalculator extends StatefulWidget {
  const CarbCalculator({super.key});

  @override
  State<CarbCalculator> createState() => _CarbCalculatorState();
}

class _CarbCalculatorState extends State<CarbCalculator> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController carbController = TextEditingController();
  var carb = 0;

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
              padding: const EdgeInsets.only(
                top: 100.0,
                right: 25.0,
                left: 25.0,
              ),
              child: _buildBodyWidget(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildPageTitle(),
        const SizedBox(height: 50.0),
        _buildContentView(context),
      ],
    );
  }

  Widget _buildPageTitle() {
    return Column(
      children: const [
        Text(
          'C A R B',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        Text(
          'C A L C U L A T O R',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ],
    );
  }

  Widget _buildContentView(BuildContext context) {
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
          _buildCarbSection(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.09),
          _buildBoulsAdviceSection(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.12),
          _buildAcceptBtn(),
        ],
      ),
    );
  }

  Widget _buildCarbSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAddBtn(),
            _buildCarbValue(),
            _buildSubBtn(),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Carb per meal',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildBoulsAdviceSection() {
    return Column(
      children: [
        Text(
          'Bouls advice',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade500,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 10.0),
        _buildBoulsAdviceWidget(),
      ],
    );
  }

  Widget _buildAcceptBtn() {
    return GestureDetector(
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: const Center(
          child: Text(
            'INJECT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'W A R N I N G',
              descriptions: 'Are you sure to add $carb units of insulin ?',
              imgUrl: 'assets/images/warning.png',
              twoAction: true,
              text1: 'Yes',
              callback1: () {
                // ..
              },
              text2: 'Cancel',
              callback2: () {
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }

  Widget _buildAddBtn() {
    return GestureDetector(
      onTap: () {
        setState(() {
          carb++;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.green,
              blurRadius: 1.5,
            ),
          ],
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.green,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildSubBtn() {
    return GestureDetector(
      onTap: () {
        if (!(carb == 0)) {
          setState(() {
            carb--;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.red,
              blurRadius: 1.5,
            ),
          ],
        ),
        child: const Icon(
          Icons.remove_rounded,
          color: Colors.red,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildCarbValue() {
    return Text(
      '$carb',
      style: const TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 64.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildBoulsAdviceWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        color: Colors.blue[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3.5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.shield_rounded,
                  color: Colors.grey.shade700,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12.0),
              const Text(
                '4.5',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 4.0),
              const Text(
                'Unit',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    title: 'Details',
                    descriptions:
                        'Hii all this is a custom dialog in flutter and  you will be use in your flutter applications',
                    imgUrl: 'assets/images/info.png',
                    twoAction: false,
                    text1: 'Ok',
                    callback1: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            },
            child: const Text(
              'Details',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
