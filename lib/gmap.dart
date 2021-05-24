import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Marker> _markers = LinkedHashSet<Marker>();
  Set<Polygon> _polygons = LinkedHashSet<Polygon>();
  Set<Polyline> _polylines =  LinkedHashSet<Polyline>();
  Set<Circle> _circles = LinkedHashSet<Circle>();

  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setPolygons();
    _setPolylines();
    _setCircles();
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/placeholder.png');
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');
    _mapController.setMapStyle(style);
  }

  void _setPolygons() {
    List<LatLng> polygonLatLongs = List<LatLng>();
    polygonLatLongs.add(LatLng(37.78493, -122.42932));
    polygonLatLongs.add(LatLng(37.78493, -122.42932));
    polygonLatLongs.add(LatLng(37.78493, -122.42932));
    polygonLatLongs.add(LatLng(37.78493, -122.42932));

    _polygons.add(Polygon(
      polygonId: PolygonId('0'),
      points: polygonLatLongs,
      fillColor: Colors.white,
      strokeWidth: 1,
    ));
  }

  void _setCircles() {
    _circles.add(Circle(
      circleId: CircleId('0'),
      center: LatLng(37.76493, -122.42432),
      radius: 1000,
      strokeWidth: 2,
      fillColor: Color.fromRGBO(102, 51, 153, 0.5),
    ));
  }

  void _setPolylines() {
    List<LatLng> polylineLatLongs = List<LatLng>();
    polylineLatLongs.add(LatLng(37.78493, -122.42932));
    polylineLatLongs.add(LatLng(37.78493, -122.42932));
    polylineLatLongs.add(LatLng(37.78493, -122.42932));
    polylineLatLongs.add(LatLng(37.78493, -122.42932));

    _polylines.add(Polyline(
      polylineId: PolylineId('0'),
      points: polylineLatLongs,
      color: Colors.purple,
      width: 1,
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      _markers.add(
          Marker(
            markerId: MarkerId('0'),
            position: LatLng(37.77483, -122.41942),
            infoWindow: InfoWindow(
              title: "San Francisco",
              snippet: "An Interesting City",
            ),
            icon: _markerIcon,
      ));
    });
    _setMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.77483, -122.41942),
              zoom: 12,
            ),
            markers: _markers,
            polygons: _polygons,
            polylines: _polylines,
            circles: _circles,
            myLocationEnabled: true,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 32),
            child: Text('Coding with Curry'),
          )
        ],
      ),
    );
  }
}
