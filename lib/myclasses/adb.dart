// run cmds
import 'dart:io';
import 'package:bloatwareremover/models/device.dart';
import 'package:bloatwareremover/models/package.dart';
import 'package:google_play_scraper/google_play_scraper.dart';

Future<ProcessResult> runADB(List<String> cmds) async {
  // String filePath = '../platform-tools';
  var result = await Process.run("adb", cmds);
  return result;
}

class Adb {
  get devicesIds async {
    var result = await runADB(['devices']);
    var lines = result.stdout.split('\n');
    var deviceIds = [];
    for (var line in lines) {
      if (line.contains('device') &&
          !line.contains('devices') &&
          !line.contains('offline')) {
        var parts = line.split('\t');
        deviceIds.add(parts[0]);
      }
    }
    return deviceIds;
  }

  Future<List<Device>> getDevices() async {
    var deviceIds = await devicesIds;
    List<Device> devices = [];
    for (var id in deviceIds) {
      var result = await runADB(['-s', id, 'shell', 'getprop']);
      var device = Device.fromText(result.stdout, id);
      devices.add(device);
    }
    return devices;
  }


  Future<List<Package>> getPackages(Device device) async {
    var result =
        await runADB(['-s', device.id, 'shell', 'pm', 'list', 'packages']);
    var lines = result.stdout.split('\n');
    List<Package> packages = [];
    String? icon;
    String? title;
    String? description;
    String? playStoreUrl;
    for (var line in lines) {
      if (line.contains('package')) {
        var parts = line.split(':');
        var id = parts[1].trim();
        var package = Package(
          id: id,
          title: title,
          iconUrl: icon,
          description: description,
          playStoreUrl: playStoreUrl,
        );
        packages.add(package);
      }
    }
    return packages;
  }
}

// void main(List<String> args) async {
//   var adb = Adb();
//   var devices = await adb.devices;
//   print(devices);
// }
