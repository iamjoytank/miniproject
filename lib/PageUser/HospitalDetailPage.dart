import 'package:flutter/material.dart';
import 'package:life_app/PageUser/UserHomePage.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
//import 'package:geolocator/geolocator.dart';

class HospitalDetailPage extends StatefulWidget {
  HospitalDetails hospitaldetails;
  HospitalDetailPage(this.hospitaldetails);
  @override
  _HospitalDetailPageState createState() => _HospitalDetailPageState();
}

class _HospitalDetailPageState extends State<HospitalDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(
          child: Row(
            children: <Widget>[
              Text('(+)Care'),
              //new Image.asset('images/LOGO_p2.png',fit: BoxFit.contain,height: 46.0,),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "${widget.hospitaldetails.getHospitalName}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      FlatButton(
                          onPressed: () => UrlLauncher.launch(
                              "google.navigation:q=${widget.hospitaldetails.getHospitalAddress},${widget.hospitaldetails.getHospitalCity}"),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.location_on, color: Colors.red),
                              Text("Location")
                            ],
                          
                          )),
                      Text(
                          "Address: ${widget.hospitaldetails.getHospitalAddress}"),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      UrlLauncher.launch(
                          "tel://${widget.hospitaldetails.getHospitalPhno}");
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.call, color: Colors.red),
                        Text("Call")
                      ],
                    ),
                  ),
                  Text("${widget.hospitaldetails.getHospitalPhno}")
                ],
              ),
            ),
            Divider(),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                          "Treatment Name: ${widget.hospitaldetails.getHTreatmentName}"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                          "Treatment Cost: Rs ${widget.hospitaldetails.getTCost}(approx)")
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Text("Doctor Name: ${widget.hospitaldetails.getHDoctorName}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// onTap: (){UrlLauncher.launch("tel://${widget.hospitalData.gethospitalPhno}");},
