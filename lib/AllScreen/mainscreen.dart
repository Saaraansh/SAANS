import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saans_app/AllScreen/searchScreen.dart';
import 'package:saans_app/AllWidgets/Divider.dart';
import 'package:saans_app/AllWidgets/progressdialog.dart';
import 'package:saans_app/Assistants/assistantMethod.dart';
import 'package:saans_app/DataHandler/appData.dart';
import 'package:saans_app/Models/directDetails.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);
  static const String idScreen=  "mainscreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}



class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin
 {
  
  Completer< GoogleMapController > _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails tripDirectionDetails ;
  List<LatLng>pLineCoordinates = [];
  Set<Polyline> polyline = {};
  Position currentPosition;
  var geoLocator = Geolocator();

  double bottomPaddingOfMap = 0;
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  double rideDetailsContainerHeight = 0;
  double searchContainerHeight=300.0;
  bool drawerOpen = true;
  resetApp()
  {
    setState(() {
      drawerOpen= true;
      searchContainerHeight=300.0;
      rideDetailsContainerHeight = 240.0;
      bottomPaddingOfMap =230.0;
      polylineSet.clear();
      markersSet.clear();
      circlesSet.clear();
      pLineCoordinates.clear();

    });
    locatePosition();
  }

  void displayRideDetailsContainer() async
  {
    await getPlaceDirection();
    setState(() {
      searchContainerHeight=0;
      rideDetailsContainerHeight = 240.0;
      bottomPaddingOfMap =230.0;
      drawerOpen = false;
    });
  }

  get polylineSet => null;
  void locatePosition()async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng letLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(target: letLatPosition, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your Address :: " + address);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  ); //cameraposition
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Main Screen"),
          ), //APPBAR
          drawer: Container(
            color: Colors.white,
            width:255.0,
            child: Drawer(
              child: ListView(
                children: [
                  Container(
                    height:165.0,
                    child: DrawerHeader(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children:[
                          Image.asset("images/user_icon.png", height: 65.0, width:65.0,),
                      SizedBox(width:16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text("Profile Name", style:TextStyle(fontSize:16.0, fontFamily:"Brand-Bold"),),
                          SizedBox(height:6.0,),
                          Text("Visit Profile"),

                        ],
                      ),

                    ],
                  ),
                ),
              ), //INNERCONTAINER

              DividerWidget(
                  SizedBox(height:12.0,),
              ),
              ListTile(
                leading:Icon(Icons.history),
                title: Text("History", style: TextStyle(fontSize:15.0,),),
              ),
              ListTile(
                leading:Icon(Icons.person),
                title: Text("Visit Profile", style: TextStyle(fontSize:15.0,),),
              ),
              ListTile(
                leading:Icon(Icons.info),
                title: Text("About", style: TextStyle(fontSize:15.0,),),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal, 
            myLocationButtonEnabled: true, 
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled:  true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: polylineSet,
            markers: markersSet,
            circles: circlesSet,
            onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController= controller;

              setState(() {
                bottomPaddingOfMap = 300.0;
              });
              locatePosition();
            }, 
          ), //MAP

        // HAMBURGER BTN
        Positioned(
          top:30.0,
          left:22.0,
          child:GestureDetector(
            onTap:()
            {
              if(drawerOpen)
                {
                  scaffoldKey.currentState.openDrawer();
                }
              else
                {
                  resetApp();
                }
            },
          child: Container(
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius:BorderRadius.circular(22.0),
            boxShadow:[
              BoxShadow(
                color:Colors.black,
                blurRadius:6.0,
                spreadRadius: 0.5,
                offset: Offset(
                  0.7,
                  0.7,
                ),
              ),
            ],
          ), //BOXDECORATION
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon((drawerOpen) ? Icons.menu : Icons.close , color:Colors.black,),
            radius:20.0,
          ),
        ),
        ),
      ),

          Positioned(
            left:0.0,
            right:0.0,
            bottom:0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: searchContainerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight:Radius.circular(15.0)),
                  boxShadow:[
                    BoxShadow(
                      color:Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7,0.7),
                    ),//BOXSHAD
                  ],
                ),//BOXDEC
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:24.0, vertical:18.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children:[
                    SizedBox(height: 6.0),
                    Text("Hello", style: TextStyle(fontSize:10.0),),
                    Text("Where to?", style: TextStyle(fontSize:20.0, fontFamily:"Brand-Bold"),),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () async
                      {
                      var res = await Navigator.push(context, MaterialPageRoute(builder: (content)=> SearchScreen() ));

                      if(res == "obtainDirection")
                      { 
                        displayRideDetailsContainer();
                      }
                      },
                      child: Container(
                         decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow:[
                      BoxShadow(
                        color:Colors.black54,
                        blurRadius: 6.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7,0.7),
                      ),//BOXSHAD2
                  ],
                ),//BOXDEC2
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                  children:[
                      Icon(Icons.search, color: Colors.greenAccent,),
                      SizedBox(width:10.0,),
                      Text("Seach Drop off")
                  ],
                ),
                ),
                      ),
                    ),//Container2
                    SizedBox(height: 24.0),
                    Row(
                      children:[
                        Icon(Icons.home, color: Colors.grey,),
                        SizedBox(width:12.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text(
                              Provider.of<AppData>(context).pickUpLocation != null
                              ? Provider.of<AppData>(context).pickUpLocation.placeName
                              : "Add Home"
                            ),
                            SizedBox(height:4.0,),
                            Text("Your Home Address", style: TextStyle(color: Colors.black54, fontSize:12.0),),
                          ],
                        ),
                      ],
                    ), //ROW

                     SizedBox(height: 10.0),
                    DividerWidget(
                     SizedBox(height: 16.0),  
                    ),
                    Row(
                      children:[
                        Icon(Icons.work, color: Colors.grey,),
                        SizedBox(width:12.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text("Add Work"),
                            SizedBox(height:4.0,),
                            Text("Your Work Address", style: TextStyle(color: Colors.black54, fontSize:12.0),),
                          ],
                        ),
                      ],
                    ), //ROW2
                  ],
                ),
                ),
              ),
            ), //Container
          ),
          
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: rideDetailsContainerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.tealAccent[100],
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Image.asset("images/ambulance.png", height: 70.0, width: 80.0,),
                              SizedBox(width: 16.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ambulance",style: TextStyle(fontSize: 18.0, fontFamily: "Brand-Bold",)
                                  ),
                                  Text(
                                    ((tripDirectionDetails != null) ?tripDirectionDetails.distanceText : ''),style: TextStyle(fontSize: 18.0, color: Colors.grey,),
                                  ),

                                ],
                              ),
                              Expanded(child: Container() ),
                              Text(
                                  ((tripDirectionDetails != null) ? '\$INR{AssitantMethods.calculateFares{tripDirectionDetails}}': '') , style: TextStyle(fontFamily: "BrandBold",)
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.0,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.moneyCheckAlt, size: 18.0, color: Colors.black54,),
                            SizedBox(width: 16.0,),
                            Text("Cash"),
                            SizedBox(width: 6.0,),
                            Icon(Icons.keyboard_arrow_down, color: Colors.black54, size: 16.0,),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.0,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: RaisedButton(
                          onPressed: ()
                          {
                            print("clicked");
                          },
                          color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: EdgeInsets.all(17.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Request", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
                                Icon(FontAwesomeIcons.taxi, color: Colors.white, size: 26.0,),
                              ],
                            ),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              
              ),
            ),
          )
        ], 
      ), 
    ); //SCAFFOLD
  }

  Future<void> getPlaceDirection() async{
    var initialPos = Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
      context:context,
      builder:(BuildContext context) => ProgressDialog(message: "Please Wait"),
    );

    var details = await AssistantMethods.obtainDirectionDetails(pickUpLatLng, dropOffLatLng);
    setState(() {
      tripDirectionDetails = details;

    });


    Navigator.pop(context);
    print("Your Encoded Points:");  
    print(details.encodedPoints);
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =polylinePoints.decodePolyline(details.encodedPoints);
    pLineCoordinates.clear();
    if(decodedPolyLinePointsResult.isNotEmpty)
      {
        decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng){
          pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
        });
      }
    polylineSet.clear();
    setState(() {
      Polyline polyline = Polyline(
        color: Colors.pinkAccent,
            polylineId: PolylineId("PolylineId"),
      jointType: JointType.round,
      points: pLineCoordinates,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,

      );
          polylineSet.add(polyline);
    });
    LatLngBounds latLngBounds;
    if(pickUpLatLng.latitude > dropOffLatLng.latitude && pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    }
    else  if(pickUpLatLng.longitude > dropOffLatLng.longitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(pickUpLatLng.latitude,dropOffLatLng.longitude), northeast: LatLng(dropOffLatLng.latitude,pickUpLatLng.longitude));


    }

    else  if(pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    }
    else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }
    newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds,70));
    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: initialPos.placeName, snippet: "my Location"),
      position: pickUpLatLng,
      markerId: MarkerId("pickUpId"),
    );
    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      infoWindow: InfoWindow(title: finalPos.placeName, snippet: "DropOff Location"),
      position: dropOffLatLng,
      markerId: MarkerId("dropOffId"),
    );
    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
    });
    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blue,
      center: pickUpLatLng,
      radius:12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("pickUpId"),
    );
    Circle dropOffLocCircle = Circle(
      fillColor: Colors.orange,
      center: dropOffLatLng,
      radius:12,
      strokeWidth: 4,
      strokeColor: Colors.orangeAccent,
      circleId: CircleId("dropOffId"),
    );
    setState(() {
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropOffLocCircle);
    });



    }
}
