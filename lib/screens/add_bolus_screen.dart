import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class AddBolusScreen extends StatefulWidget {
  const AddBolusScreen({super.key, this.device});

  final BluetoothDevice? device;

  @override
  State<AddBolusScreen> createState() => _AddBolusScreenState();
}

class _AddBolusScreenState extends State<AddBolusScreen> {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    elevation: 5.0,
    padding: const EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  );

  bool _isReady = false;

  final String SERVICE_UUID = "b172ab92-fc20-11ed-be56-0242ac120002";
  final String CHARACTERISTIC_UUID_RX = "b172ab92-fc20-11ed-be56-0242ac120002";

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}