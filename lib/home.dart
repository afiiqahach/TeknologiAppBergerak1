import 'package:flutter/material.dart';
import 'package:tugas1/koordinat.dart';
import 'package:tugas1/qrscan.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: const Color.fromARGB(255, 146, 69, 63),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 146, 69, 63))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const QrScan()));
                  },
                  child: Text('Scan QR')),
              SizedBox(height: 25),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 146, 69, 63))),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const KoordinatGps()),
                  );
                },
                child: Text('GPS Coordinates'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
