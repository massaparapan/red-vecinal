import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/features/community/repositories/community_respository.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:frontend/features/community/services/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/shared/widgets/primary_button.dart';
import 'package:flutter/services.dart';
import 'package:frontend/features/community/presentation/widgets/community_window_details.dart';

class NearbyCommunitiesMap extends StatefulWidget {
  const NearbyCommunitiesMap({super.key});

  @override
  State<NearbyCommunitiesMap> createState() => _NearbyCommunitiesMapState();
}

class _NearbyCommunitiesMapState extends State<NearbyCommunitiesMap> {
  final Map<String, Map<String, dynamic>> _annotationCommunityMap = {};
  late final PointAnnotationManager _annotationManager;
  final _communityRepository = CommunityRespository();
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
    print("posicion ${position?.latitude}, ${position?.longitude}");
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
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          MapWidget(key: const ValueKey("map"), onMapCreated: _onMapCreated),
          Positioned(
            bottom: 40,
            left: 50,
            child: PrimaryButton(
              label: 'Volver',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 80,
            right: 20,
            child: FloatingActionButton(
              heroTag: 'center_user',
              onPressed: _centerMapOnUser,
              tooltip: 'Centra el mapa en tu ubicación',
              child: const Icon(
                Icons.my_location,
                color: Color.fromARGB(255, 0, 0, 0),
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(MapboxMap controller) async {
    setState(() {
      mapboxMapController = controller;
    });

    mapboxMapController?.location.updateSettings(
      LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );

    final annotationPlugion = mapboxMapController!.annotations;
    _annotationManager = await annotationPlugion.createPointAnnotationManager();

    await _loadNearbyCommunities();

    if (_currentPosition != null) {
      final center = Point(
        coordinates: Position(
          _currentPosition!.longitude,
          _currentPosition!.latitude,
        ),
      );

      final cameraOptions = CameraOptions(center: center, zoom: 14.0);

      mapboxMapController?.setCamera(cameraOptions);
      mapboxMapController?.flyTo(
        cameraOptions,
        MapAnimationOptions(duration: 1000),
      );

      mapboxMapController?.setBounds(
        CameraBoundsOptions(
          bounds: CoordinateBounds(
            southwest: Point(
              coordinates: Position(
                _currentPosition!.longitude - 0.01,
                _currentPosition!.latitude - 0.01,
              ),
            ),
            northeast: Point(
              coordinates: Position(
                _currentPosition!.longitude + 0.01,
                _currentPosition!.latitude + 0.01,
              ),
            ),
            infiniteBounds: false,
          ),
        ),
      );
    }
  }

  void _centerMapOnUser() {
    if (_currentPosition != null && mapboxMapController != null) {
      final center = Point(
        coordinates: Position(
          _currentPosition!.longitude,
          _currentPosition!.latitude,
        ),
      );

      final cameraOptions = CameraOptions(center: center, zoom: 14.0);

      mapboxMapController!.flyTo(
        cameraOptions,
        MapAnimationOptions(duration: 1000),
      );
    }
  }

  Future<void> _loadNearbyCommunities() async {
    if (_currentPosition == null || mapboxMapController == null) return;

    final ByteData bytes = await rootBundle.load('assets/comunidad.png');
    final Uint8List imageData = bytes.buffer.asUint8List();

    final communities = await _communityRepository.getCloseCommunities(
      lat: _currentPosition!.latitude,
      lon: _currentPosition!.longitude,
    );

    for (final community in communities) {
      final double lat = double.tryParse(community.lat) ?? 0;
      final double lon = double.tryParse(community.lon) ?? 0;

      if (lat == 0 || lon == 0) {
        continue;
      }

      final options = PointAnnotationOptions(
        geometry: Point(coordinates: Position(lon, lat)),
        image: imageData,
        iconSize: 0.2,
      );

      final annotation = await _annotationManager.create(options);

      _annotationCommunityMap[annotation.id] = community.toJson();

      _annotationManager.addOnPointAnnotationClickListener(
        CommunityAnnotationClickListener(
          context: context,
          annotationCommunityMap: _annotationCommunityMap,
        ),
      );
    }
  }
}

class CommunityAnnotationClickListener extends OnPointAnnotationClickListener {
  final BuildContext context;
  final Map<String, Map<String, dynamic>> annotationCommunityMap;

  CommunityAnnotationClickListener({
    required this.context,
    required this.annotationCommunityMap,
  });

  @override
  bool onPointAnnotationClick(PointAnnotation annotation) {
    final community = annotationCommunityMap[annotation.id];
    if (community != null) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder:
            (context) => Dialog(
              insetPadding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CommunityWindowDetails(
                name: community['name'],
                description: community['description'],
                latitude: double.parse(community['lat'].toString()),
                longitude: double.parse(community['lon'].toString()),
                memberCount: community['membersCount'] ?? 0,
              ),
            ),
      );
    }
    return true;
  }
}
