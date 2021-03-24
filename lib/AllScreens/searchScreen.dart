
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/AllScreens/mainScreen.dart';
import 'package:tracking_app/AllWidgets/Divider.dart';
import 'package:tracking_app/Assistants/allinfo.dart';
import 'package:tracking_app/Assistants/requestAssistant.dart';
import 'package:tracking_app/DataHandle/appData.dart';
import 'package:tracking_app/Models/placePrediction.dart';
import 'package:tracking_app/configMap.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];
  @override
  Widget build(BuildContext context) {
    String placeAddress = allinfo.address;
    print(placeAddress);
    pickUpTextEditingController.text = placeAddress;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 25.0, top: 20.0, right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 5.0),
                  Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)),
                      Center(
                        child: Text(
                          "Set Drop off",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Image.asset(
                        "images/car_demo.jpg",
                        height: 16.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              controller: pickUpTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Pickup Location",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Image.asset(
                        "images/car_demo.jpg",
                        height: 16.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              onChanged: (val) {
                                findPlace(val);
                              },
                              controller: dropOffTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Where to ?",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //tile for predictions
          (placePredictionList.length>0)
          ? Padding(padding:EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
          child: ListView.separated(
            padding: EdgeInsets.all(0.0), 
            itemBuilder: (context,index)
            {
              return PredictionTile(placePredictions: placePredictionList[index],);
            },
            separatorBuilder: (BuildContext context,int index)=>DividerWidget(),
            itemCount: placePredictionList.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            ),
            )
            : Container(),
        ],
      ),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoComplterUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:IN";
      var res = await RequestAssitant.getRequest(autoComplterUrl);
      if (res == "failed") {
        return;
      }
      if (res["status"] == "OK") {
        var predictions = res["predictions"];
        var placeslist = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();
        setState(() {
            placePredictionList = placeslist;
        });

      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;
  PredictionTile({Key key, this.placePredictions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: [
          SizedBox(width: 10.0,),
          Row(
           children: [
             Icon(Icons.add_location),
             SizedBox(
              width: 14.0,
            ),
            Expanded(
                        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    placePredictions.main_text, overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    placePredictions.secondary_text,overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(width: 10.0,),
        ],
      ),
    );
  }
}
