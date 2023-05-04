import 'package:flutter/material.dart';
import 'package:insucare/utils/styles.dart';
import 'package:insucare/widgets/real_time_chart.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    elevation: 5.0,
    padding: const EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  );

  bool _isActive = true;
  String _status = 'active';

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo2.png',
                    height: 100,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 35.0),
                  _buildActionsSection(),
                  const SizedBox(height: 30.0),
                  _buildStatusSection(),
                  const SizedBox(height: 30.0),
                  _buildRealTimeSection(),
                  const SizedBox(height: 30.0),
                  _buildInsulinDeliverySection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPumpActionWidget(),
        _buildAddBolusWidget(),
      ],
    );
  }

  Widget _buildPumpActionWidget() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isActive = !_isActive;
          if (_isActive) {
            _status = 'active';
          } else {
            _status = 'not active';
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 20.0,
          right: 15.0,
          left: 15.0,
          bottom: 20.0,
        ),
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
          gradient: const LinearGradient(
            colors: [
              Color(0xff23b6e6),
              Color(0xff02d39a),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.42,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pump is \n$_status',
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              _isActive
                  ? Icons.pause_circle_outline_rounded
                  : Icons.play_circle_outline_rounded,
              color: Colors.white,
              size: 36,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddBolusWidget() {
    return GestureDetector(
      onTap: () {
        // ..
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 20.0,
          right: 15.0,
          left: 15.0,
          bottom: 20.0,
        ),
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              const Color(0xff23b6e6),
              Colors.blueAccent.shade700,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.42,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                Text(
                  'emergancy',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                Text(
                  'bolus',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    height: 1,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.white,
              size: 36,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10.0),
        _buildGlucoseWidget(),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildReservoirWidget(),
            _buildBatteryWidget(),
          ],
        ),
      ],
    );
  }

  Widget _buildGlucoseWidget() {
    return Container(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 15.0,
        left: 15.0,
        bottom: 10.0,
      ),
      decoration: kBoxDecorationStyle,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Glucose',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                child: Row(
                  children: const [
                    Text(
                      'Last monitoring at 9:07',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4.0),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 14,
                    ),
                  ],
                ),
                onTap: () {
                  // ...
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text(
                    '4.2',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 42,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    'mmol/l',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 16,
                      height: 4,
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Icon(
                    Icons.check_circle,
                    color: Colors.greenAccent,
                    size: 22,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    'normal',
                    style: TextStyle(
                      color: Colors.lightGreenAccent,
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReservoirWidget() {
    return Container(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 15.0,
        left: 15.0,
        bottom: 10.0,
      ),
      decoration: kBoxDecorationStyle,
      width: MediaQuery.of(context).size.width * 0.42,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Reservoir',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 15.0),
              Text(
                '2d last',
                style: TextStyle(
                  color: Colors.lightGreenAccent,
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                  value: 0.9,
                ),
              ),
              SizedBox(width: 10),
              Text(
                '235',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4.0),
              Text(
                'U',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 24,
                  height: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBatteryWidget() {
    return Container(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 15.0,
        left: 15.0,
        bottom: 10.0,
      ),
      decoration: kBoxDecorationStyle,
      width: MediaQuery.of(context).size.width * 0.42,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Battery',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 15.0),
              Text(
                'change',
                style: TextStyle(
                  color: Colors.lightGreenAccent,
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(
                Icons.battery_4_bar_rounded,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: 4.0),
              Text(
                '58',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4.0),
              Text(
                '%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  height: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRealTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Real time monitoring',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10.0),
        _buildRealTimeChartWidget(),
        const SizedBox(height: 15.0),
        _buildKeyChartWidget(),
      ],
    );
  }

  Widget _buildRealTimeChartWidget() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15.0,
        right: 15.0,
        left: 15.0,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 54, 107, 173),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: const [
          RealTimeChartWidget(),
        ],
      ),
    );
  }

  Widget _buildKeyChartWidget() {
    return Column(
      children: [
        Row(
          children: const [
            Icon(
              Icons.circle,
              color: Colors.lightBlueAccent,
              size: 18,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              'The level of glucose (mmoI/I)',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          children: const [
            Icon(
              Icons.circle,
              color: Colors.greenAccent,
              size: 18,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              'Active Insulin (U/h)',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInsulinDeliverySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Insulin delivery',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 20,
              ),
            ),
            GestureDetector(
              onTap: () {
                // ..
              },
              child: Row(
                children: const [
                  Text(
                    'See all',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _buildInsulinTableWidget(),
      ],
    );
  }

  Widget _buildInsulinTableWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Head of the table
          _buildHeadOfTable('16', 'Oct 15'),
          // Rows of the table
          _buildRowOfTable('3', '21:15'),
          _buildRowOfTable('2', '20:15'),
          _buildRowOfTable('1.5', '19:15'),
          _buildRowOfTable('1.25', '18:15'),
          // footer of the table
          _buildFooterOfTable('1.5', '17:30')
        ],
      ),
    );
  }

  Widget _buildHeadOfTable(units, time) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15.0,
        right: 15.0,
        left: 15.0,
        bottom: 15.0,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF6CA8F1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            units + ' U Total',
            style: const TextStyle(
              color: Colors.lightGreenAccent,
              fontFamily: 'SFProText',
              fontSize: 18,
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'SFProText',
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowOfTable(units, time) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 15.0,
        left: 15.0,
        bottom: 10.0,
      ),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 55, 110, 175),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            units + ' units',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'SFProText',
              fontSize: 16,
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'SFProText',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterOfTable(units, time) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 15.0,
        left: 15.0,
        bottom: 10.0,
      ),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 54, 107, 173),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            units + ' units',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'SFProText',
              fontSize: 16,
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'SFProText',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
