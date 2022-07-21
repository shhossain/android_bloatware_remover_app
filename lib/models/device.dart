import 'package:flutter/cupertino.dart';

class Device {
  final String id;
  final String brand;
  final String model;
  final String osVersion;
  final String? name;
  final Size? size;

  const Device({
    required this.id,
    required this.brand,
    required this.model,
    required this.osVersion,
    required this.name,
    this.size,
  });

  get phoneName {
    if (name != null) {
      return name!.toUpperCase();
    }
    return '$brand $model'.toUpperCase();
  }

  // from raw text ex [sys.aps.minBrightDuration]: [70000] [sys.boot.reason]: [0]
  factory Device.fromText(String text, String id) {
    Map<String, String> info = {};
    var lines = text.split('\n');
    for (var line in lines) {
      var parts = line.split(':');

      if (parts.length > 1) {
        var name = parts[0].toLowerCase();
        var value = parts[1];
        value = value.replaceAll("[", "").replaceAll("]", "");

        if (name.contains('brand')) {
          info['brand'] = value;
        } else if (name.contains('custname')) {
          info['name'] = value;
        } else if (name.contains('model')) {
          info['model'] = value;
        } else if (name.contains('release')) {
          info['osVersion'] = value;
        }
      }
    }

    return Device(
      brand: info['brand']!,
      model: info['model']!,
      osVersion: info['osVersion']!,
      name: info['name'],
      id: id,
    );
  }
}

List<Device> testDevice = [
  const Device(
    id: 'emulator-5554',
    brand: 'Samsung',
    model: 'SM-G955F',
    osVersion: '9.0',
    name: 'Galaxy S9',
    size: Size(1440, 2960),
  ),
  const Device(
    id: 'emulator-5556',
    brand: 'Pixel',
    model: 'Pixel 3',
    osVersion: '9.0',
    name: 'Pixel 3',
    size: Size(1440, 2960),
  ),
  const Device(
    id: 'emulator-5557',
    brand: 'Pixel',
    model: 'Pixel 3 XL',
    osVersion: '9.0',
    name: 'Pixel 3 XL',
    size: Size(1440, 2960),
  ),
  const Device(
    id: 'emulator-5558',
    brand: 'Pixel',
    model: 'Pixel 3',
    osVersion: '9.0',
    name: 'Pixel 3',
    size: Size(1440, 2960),
  ),
];
