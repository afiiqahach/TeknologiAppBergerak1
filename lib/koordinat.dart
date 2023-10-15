import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class KoordinatGps extends StatefulWidget {
  const KoordinatGps({super.key});

  @override
  State<KoordinatGps> createState() => _KoordinatGpsState();
}

class _KoordinatGpsState extends State<KoordinatGps> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentAdress = '';

  // mengecek apakah kita memiliki permission untuk akses lokasi
  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print('Service disable');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  // menambahkan koordinat geocode dan mengubahnya ke dalam bentuk alamat
  _getAdressFromCoordinates() async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);

      Placemark place = placemark[0];

      setState(() {
        _currentAdress = '${place.locality}, ${place.country}';
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS Coordinates'),
        backgroundColor: const Color.fromARGB(255, 146, 69, 63),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 125, 151, 164),
          margin: EdgeInsets.fromLTRB(100, 20, 100, 280),
          width: MediaQuery.of(context).size.width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Location Coordinate',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Latitude = ${_currentLocation?.latitude} ; Longitude = ${_currentLocation?.longitude}',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Location Address',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('${_currentAdress}'),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  // fungsi mendapatkan lokasi yang diinginkan
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 146, 69, 63))),
                  onPressed: () async {
                    _currentLocation = await _getCurrentLocation();
                    await _getAdressFromCoordinates();
                    print('${_currentLocation}');
                    print('${_currentAdress}');
                  },
                  child: Text('Get Location'))
            ],
          ),
        ),
      ),
    );
  }
}
