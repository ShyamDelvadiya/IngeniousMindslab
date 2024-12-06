import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;

    print(arguments);

    arguments = arguments['airPorts'];
    String name = arguments['name'] ?? 'Unknown Airport';
    String city = arguments['city'] ?? 'Unknown City';
    String state = arguments['state'] ?? 'Unknown State';
    String country = arguments['country'] ?? 'Unknown Country';
    double latitude = arguments['lat'] ?? 0.0;
    double longitude = arguments['lon'] ?? 0.0;
    return Scaffold(
     
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Airport Details Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('City: $city', style: const TextStyle(fontSize: 16)),
                      Text('State: $state', style: const TextStyle(fontSize: 16)),
                      Text('Country: $country',
                          style: const TextStyle(fontSize: 16)),
                      Text(
                        'Coordinates: ($latitude, $longitude)',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                // Map Section
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(latitude, longitude),
                      initialZoom: 10.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                        keepBuffer: 2,
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(latitude, longitude),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
