import 'package:connectivity_plus/connectivity_plus.dart'
    show ConnectivityResult, Connectivity;
import 'package:flutter/material.dart';

class CheckStatusScreen extends StatefulWidget {
  const CheckStatusScreen({super.key});

  @override
  State<CheckStatusScreen> createState() => _CheckStatusScreenState();
}

class _CheckStatusScreenState extends State<CheckStatusScreen> {
  String status = 'Checking ...';

  String checkConnected(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.wifi)) {
      return 'wifi';
    } else if (result.contains(ConnectivityResult.mobile)) {
      return 'Mobile';
    } else {
      return 'None';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connectivity Plus'), centerTitle: true),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                Connectivity().onConnectivityChanged.listen((
                  List<ConnectivityResult> result,
                ) {
                  status = checkConnected(result);
                });
              });
            },
            child: Text('Check Connectivity: $status'),
          ),
        ],
      ),
    );
  }
}
