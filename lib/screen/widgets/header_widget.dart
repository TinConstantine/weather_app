import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HeaderWidget extends StatefulWidget {
  double lat;
  double lon;
  HeaderWidget({super.key, required this.lat, required this.lon});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());
  @override
  void initState() {
    getAddress(lat: widget.lat, lon: widget.lon);
    super.initState();
  }

  getAddress({required double lat, required double lon}) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placeMark[0];
    setState(() {
      city = place.subAdministrativeArea!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(city, style: const TextStyle(fontSize: 35, height: 2)),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style:
                const TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
          ),
        )
      ],
    );
  }
}
