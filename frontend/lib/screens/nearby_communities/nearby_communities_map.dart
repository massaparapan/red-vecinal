import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:frontend/screens/get_close_communities_screen/local_services/location_service.dart';
import 'package:flutter/foundation.dart';




class NearbyCommunitiesMap extends StatefulWidget {

  const NearbyCommunitiesMap({super.key});

  @override
  State<NearbyCommunitiesMap> createState() => _NearbyCommunitiesMapState();
}

class _NearbyCommunitiesMapState extends State<NearbyCommunitiesMap> {

  bool _mapReady = false;
  geo.Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    
    await dotenv.load(fileName: "assets/.env");

    final position = await LocationService.getCurrentLocation();
    print ("posicion ${position?.latitude}, ${position?.longitude}");
    if (position == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo obtener tu ubicación.')),
        );
      }
      return;
    }

    if (!kIsWeb) {
    MapboxOptions.setAccessToken(dotenv.env["MAPBOX_ACCESS_TOKEN"]!);
    }

    setState(() {
      _currentPosition = position;
      _mapReady = true;
    });
  }

  MapboxMap? mapboxMapController;

  @override
  Widget build(BuildContext context) {
    if (!_mapReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: MapWidget(
        key: const ValueKey("map"),
        onMapCreated: _onMapCreated
      ),
    );
  }

  void _onMapCreated(MapboxMap controller) {

    setState(()
    {
      mapboxMapController = controller;
    });

    mapboxMapController?.location.updateSettings(LocationComponentSettings(enabled: true, pulsingEnabled: true ));


  }
}