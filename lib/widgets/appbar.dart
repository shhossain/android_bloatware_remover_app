import 'package:bloatwareremover/constants.dart';
import 'package:bloatwareremover/models/device.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatefulWidget {
  final List<Device> devices;
  final dynamic onChanged;
  final dynamic onChanged2;
  const CustomAppBar(
      {Key? key, required this.devices, this.onChanged, this.onChanged2})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  Device? currentDevice;
  List<String> methods = ['Recomended', 'Advanced', 'Expert'];
  List<IconData> methodsIcons = [
    FontAwesomeIcons.thumbsUp,
    FontAwesomeIcons.gears,
    FontAwesomeIcons.userGear
  ];
  int currentMethod = 0;

  @override
  void initState() {
    if (widget.devices.isNotEmpty) {
      setState(() {
        currentDevice = widget.devices[0];
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.white
            : Colors.black;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(
              top: kDefaultPadding / 5,
              left: kDefaultPadding / 2,
              right: kDefaultPadding / 2),
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              child: widget.devices.isNotEmpty
                  ? DropDownButton(
                      menuColor: iconColor,
                      leading: const Icon(FontAwesomeIcons.mobile, size: 24),
                      title: Text(currentDevice == null
                          ? widget.devices[0].phoneName
                          : currentDevice!.phoneName),
                      items: widget.devices.map((device) {
                        return MenuFlyoutItem(
                          leading: const Icon(FontAwesomeIcons.mobile),
                          text: Text(device.phoneName),
                          onPressed: () {
                            setState(() {
                              currentDevice = device;
                            });
                            widget.onChanged(device);
                          },
                          selected: device == currentDevice,
                        );
                      }).toList(),
                    )
                  : DropDownButton(
                      title: const Text('No devices found'),
                      leading: const Icon(FontAwesomeIcons.mobile),
                      disabled: true,
                      items: [
                          MenuFlyoutItem(
                            leading: const Icon(FontAwesomeIcons.mobile),
                            text: const Text('No devices found'),
                            onPressed: () {},
                          ),
                        ]),
            ),
          ),
        ),
        // method dropdown
        Container(
          padding: EdgeInsets.only(
              top: kDefaultPadding / 5,
              left: kDefaultPadding / 2,
              right: kDefaultPadding / 2),
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              child: DropDownButton(
                menuColor: iconColor,
                leading: Icon(methodsIcons[currentMethod], size: 24),
                title: Text(methods[currentMethod]),
                items: methods.map((method) {
                  return MenuFlyoutItem(
                    leading: Icon(methodsIcons[methods.indexOf(method)]),
                    text: Text(method),
                    onPressed: () {
                      setState(() {
                        currentMethod = methods.indexOf(method);
                      });
                      if (widget.onChanged2 != null) {
                        widget.onChanged2(method);
                      }
                    },
                    selected: methods.indexOf(method) == currentMethod,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
