import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';

class PhoneConstraints {                 // Look, the slashes are perfectly diagonal 😁
  static double target = -10.0;         // This is the device's Z position where it's considered "perfectly face down"
  static double enterLeniency = 1.0;   // If the device's Z position is -9 or -11 we still count it as face down
  static double exitLeniency = 2.5;   // If the device's Z position is -2.5 or +2.5 past target, we count it as face up.
  static bool phoneFaceDown = false;
  static StreamSubscription? subscription;  // Imagine *not* knowing what StreamSubscription does :smirk: 😏

  static void startDetecting({VoidCallback? onUpdate}) {  // onUpdate is used to call SetState when my bool updates. We make it nullable so that it's optional 
    subscription = accelerometerEventStream(
      samplingPeriod: SensorInterval.normalInterval,
    ).listen((AccelerometerEvent event) {
      final distance = (event.z - target).abs();          // .abs() makes it so that if the value is negative, make it postive, if it's positive, leave it like that (its absolute value) 

      if (!phoneFaceDown && distance <= enterLeniency) {
        phoneFaceDown = true;
        onUpdate?.call();                                 // If my dumbass accidentally calls detectAccelerometer() by mistake without onUpdate, It won't cause problems :)
      } else if (phoneFaceDown && distance > exitLeniency) {
        phoneFaceDown = false;
        onUpdate?.call();
      }
    });
  }

  static void stopDetecting() {                           // MEMORY LEAKSSSSS!!!!
    subscription?.cancel();
  }
}
