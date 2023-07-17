import 'package:flutter/material.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:geo_attendance_system/src/models/office.dart';

class GeoFencing extends InheritedWidget {
  GeoFencing({
    super.key,
    required super.child,
    required this.service,
  });

  final GeoFencingService service;

  @override
  bool updateShouldNotify(InheritedWidget old) => true;

  static GeoFencing of(BuildContext context) {
    final GeoFencing? result =
        context.dependOnInheritedWidgetOfExactType<GeoFencing>();
    assert(result != null, 'No GeoFencingService found in context');
    return result!;
  }
}

class GeoFencingService with ChangeNotifier {
  GeofenceStatus geofenceStatus = GeofenceStatus.init;

  void startGeofencing() {
    EasyGeofencing.stopGeofenceService();

    EasyGeofencing.startGeofenceService(
      pointedLatitude: "28.644871081269685",
      pointedLongitude: "77.32609798104342",
      radiusMeter: 50.toString(),
      eventPeriodInSeconds: 5,
    );

    EasyGeofencing.getGeofenceStream()!.listen((GeofenceStatus status) {
      geofenceStatus = status;
      notifyListeners();
    });
  }
}
