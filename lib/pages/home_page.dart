import 'package:bloatwareremover/constants.dart';
import 'package:bloatwareremover/models/package.dart';
import 'package:bloatwareremover/myclasses/adb.dart';
import 'package:bloatwareremover/models/device.dart';
import 'package:bloatwareremover/widgets/appbar.dart';
import 'package:fluent_ui/fluent_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Package>> _packages = Future.value([]);
  List<Device> devicesList = [];
  bool isSelectedAll = false;
  List<Package> loadedPackages = [];

  onChanged(Device device) {
    Adb adb = Adb();
    setState(() {
      _packages = adb.getPackages(device);
    });
  }

  onMethodChanged(String method) {
    // print(method);
  }

  @override
  void initState() {
    setDevices();
    super.initState();
  }

  updateDevices() async {
    if (!deviceUpdating) {
      deviceUpdating = true;
      while (true) {
        if (!updateDeviceLoop) {
          updateDeviceLoop = true;
          break;
        }
        await Future.delayed(const Duration(seconds: 1));
        Adb adb = Adb();
        List<Device> devices = await adb.getDevices();
        if (devices.isNotEmpty) {
          try {
            setState(() {
              devicesList = devices;
            });
          } catch (_) {}
        }
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  }

  @override
  void dispose() {
    deviceUpdating = false;
    super.dispose();
  }

  setDevices() async {
    Adb adb = Adb();
    var allDevices = await adb.getDevices();
    setState(() {
      devicesList = allDevices;
    });

    if (allDevices.isNotEmpty) {
      var device = allDevices.first;
      setState(() {
        _packages = adb.getPackages(device);
      });
    }
    updateDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          devices: devicesList,
          onChanged: onChanged,
          onChanged2: onMethodChanged,
        ),
        Row(
          children: [
            Checkbox(
                checked: isSelectedAll,
                onChanged: (value) {
                  setState(() {
                    isSelectedAll = !isSelectedAll;
                    for (var package in loadedPackages) {
                      package.isSelected = isSelectedAll;
                    }
                  });
                }),
            const Text('Select all'),
          ],
        ),
        FutureBuilder(
          future: _packages,
          builder: (context, AsyncSnapshot snapshot) {
            ConnectionState state = snapshot.connectionState;
            if (state == ConnectionState.waiting) {
              return const Center(
                child: ProgressRing(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              loadedPackages = snapshot.data;
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    Package package = snapshot.data[index];
                    return GestureDetector(
                      onLongPress: () {
                        setState(() {
                          isSelectedAll = !isSelectedAll;
                        });
                        package.isSelected = !package.isSelected;
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: package.isSelected
                                ? Colors.red.light
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              checked: package.isSelected,
                              onChanged: (value) {
                                setState(() {
                                  package.isSelected = !package.isSelected;
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                package.id,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
