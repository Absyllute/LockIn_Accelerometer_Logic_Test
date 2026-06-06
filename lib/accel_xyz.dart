import 'package:accel_test/constraints.dart';
import 'package:accel_test/is_phone_face_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelXyz extends StatefulWidget {
  const AccelXyz({super.key});

  @override
  State<AccelXyz> createState() => _AccelXyzState();
}

class _AccelXyzState extends State<AccelXyz> {

  void _startDisplaying() {
  accelerometerEventStream(
    samplingPeriod: SensorInterval.normalInterval
      ).listen((AccelerometerEvent event) {
      setState(() {
        xPos = 'X: ${event.x.toStringAsFixed(1)}';
        yPos = 'Y: ${event.y.toStringAsFixed(1)}';
        zPos = 'Z: ${event.z.toStringAsFixed(1)}';
      });
    });
  }

  late String xPos = '0.0';
  late String yPos = '0.0';
  late String zPos = '0.0';

  @override
  void initState() {
    _startDisplaying();
    super.initState();
  }

  @override
  void dispose() {
    PhoneConstraints.stopDetecting();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accelerometer Test'),
      ),

      body: Center(
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
            fontSize: 24
          ),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text(xPos),
              Text(yPos),
              Text(zPos),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => IsPhoneFaceDown(),
                    )
                  );
                },
                child: Text('Face Down Test')
              )
            ],
          ),
        ),
      ),
    );
  }
}