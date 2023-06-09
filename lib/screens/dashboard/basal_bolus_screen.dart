import 'package:flutter/material.dart';
import 'package:insucare/dialog/custom_dialog.dart';
import 'package:insucare/screens/programs_screen.dart';

class BasalBolusScreen extends StatefulWidget {
  const BasalBolusScreen({super.key});

  @override
  State<BasalBolusScreen> createState() => _BasalBolusScreenState();
}

class _BasalBolusScreenState extends State<BasalBolusScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController carbController = TextEditingController();

  int _widgetSelected = 0;
  var carb = 0;
  var wholeNum = 0;
  var fractionalNum = 5;

  @override
  void initState() {
    super.initState();
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
        _buildCategorysSection(),
        const SizedBox(height: 30.0),
        _widgetSelected == 0
            ? _buildBasalContentView(context)
            : _buildBolusContentView(context),
      ],
    );
  }

  Widget _buildPageTitle() {
    return const Text(
      'P R O G R A M S',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
    );
  }

  Widget _buildCategorysSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBasalWidget(),
        _buildBolusWidget(),
      ],
    );
  }

  Widget _buildBasalWidget() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _widgetSelected = 0;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 20.0,
          right: 15.0,
          left: 15.0,
          bottom: 20.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: _widgetSelected == 0
              ? Border.all(
                  color: Colors.indigo.shade900,
                  width: 5.0,
                )
              : Border.all(color: Colors.transparent),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.42,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basal',
              style: TextStyle(
                color: Colors.lightBlue[900],
                fontFamily: 'OpenSans',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '9.50 U',
              style: TextStyle(
                color: Colors.lightBlue[900],
                fontFamily: 'OpenSans',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBolusWidget() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _widgetSelected = 1;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 20.0,
          right: 15.0,
          left: 15.0,
          bottom: 20.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: _widgetSelected == 1
              ? Border.all(
                  color: Colors.indigo.shade900,
                  width: 5.0,
                )
              : Border.all(color: Colors.transparent),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.42,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bolus',
              style: TextStyle(
                color: Colors.lightBlue[900],
                fontFamily: 'OpenSans',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '7.20 U',
              style: TextStyle(
                color: Colors.lightBlue[900],
                fontFamily: 'OpenSans',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // START OF BASAL CONTENT

  Widget _buildBasalContentView(BuildContext context) {
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
          _buildInsulinSection(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.085),
          _buildNotesSection(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.12),
          _buildProgramBtn(context),
        ],
      ),
    );
  }

  Widget _buildInsulinSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAddInsulinBtn(),
            _buildInsulinValue(),
            _buildSubInsulinBtn(),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Unit of insulin',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildInsulinValue() {
    return Text(
      '$wholeNum.$fractionalNum',
      style: const TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 64.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildAddInsulinBtn() {
    return GestureDetector(
      onTap: () {
        if (wholeNum < 2) {
          setState(() {
            fractionalNum++;
            if (fractionalNum == 10) {
              wholeNum++;
              fractionalNum = 0;
            }
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

  Widget _buildSubInsulinBtn() {
    return GestureDetector(
      onTap: () {
        if (!(fractionalNum == 0) || wholeNum > 0) {
          setState(() {
            if (fractionalNum - 1 == -1) {
              wholeNum--;
              fractionalNum = 10;
            }
            fractionalNum--;
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

  Widget _buildNotesSection() {
    return Column(
      children: [
        Text(
          'Notes',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade500,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 16.0),
        _buildNoteWidget('The default value = 0.5'),
        const SizedBox(height: 8.0),
        _buildNoteWidget('The max value = 2.0'),
      ],
    );
  }

  Widget _buildNoteWidget(note) {
    return Row(
      children: [
        const SizedBox(width: 14.0),
        Container(
          width: 15,
          height: 15,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 15.0),
        Text(
          note,
          style: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }

  Widget _buildProgramBtn(BuildContext context) {
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
            'PROGRAMS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProgramsScreen(),
          ),
        );
      },
    );
  }

  // END OF BASAL CONTENT

  // START OF BOLUS CONTENT

  Widget _buildBolusContentView(BuildContext context) {
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
          _buildInjectBtn(),
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
    /*
    return Form(
      key: formKey,
      child: Container(
        height: 25.0,
        child: TextFormField(
          controller: carbController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Fill Out The Field';
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.number,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
    */
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
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInjectBtn() {
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

  // END OF BOLUS CONTENT
}
