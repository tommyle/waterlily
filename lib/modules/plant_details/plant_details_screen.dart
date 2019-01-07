import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../components/common.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../plants/plants_provider.dart';

class PlantDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final plantsProvider = PlantsProvider.of(context);
    final plantDetailsBloc = plantsProvider.plantDetailsBloc;

    return Scaffold(
      appBar: defaultAppBar("Plant Details"),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
          ),
          imageCarousel(),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: StreamBuilder(
              stream: plantDetailsBloc.name,
              builder: (context, snapshot) {
                return TextField(
                    onChanged: plantDetailsBloc.changeName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "Give your plant a name", labelText: "Name"));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: StreamBuilder(
              stream: plantDetailsBloc.location,
              builder: (context, snapshot) {
                return TextField(
                    onChanged: plantDetailsBloc.changeLocation,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "Where your plant located",
                        labelText: "Location"));
              },
            ),
          ),
          frequencyControl(plantDetailsBloc),
          CupertinoButton(
            child: Text("Create"),
            color: Colors.blue,
            onPressed: () {
              plantsProvider.addNewPlant();
              Navigator.pop(context);
            },
          ),
        ],
      )),
    );
  }

  Widget frequencyControl(PlantDetailsBloc bloc) {
    return Container(
        child: Column(children: <Widget>[
      StreamBuilder(
          stream: bloc.wateringSchedule,
          builder: (context, AsyncSnapshot<int> snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: snapshot.data,
                  onChanged: (value) => bloc.changeWateringSchedule(value),
                ),
                Text(
                  'Daily',
                  style: TextStyle(fontSize: 16.0),
                ),
                Radio(
                  value: 1,
                  groupValue: snapshot.data,
                  onChanged: (value) => bloc.changeWateringSchedule(value),
                ),
                Text(
                  'Weekly',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Radio(
                  value: 2,
                  groupValue: snapshot.data,
                  onChanged: (value) => bloc.changeWateringSchedule(value),
                ),
                Text(
                  'Monthly',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            );
          }),
      Container(
          padding: EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 20),
          child: Column(children: <Widget>[
            StreamBuilder(
                stream: bloc.getWateringScheduleAndFrequency,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  return Text(snapshot.data ??
                      "You have not seleted a watering frequency");
                }),
            StreamBuilder(
                stream: bloc.wateringFrequency,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  return Slider(
                    min: 0.0,
                    max: 15.0,
                    onChanged: (value) =>
                        bloc.changeWateringFrequency(value.toInt()),
                    value: snapshot.hasData ? snapshot.data.toDouble() : 0,
                  );
                })
          ])),
    ]));
  }

  Widget imageCarousel() {
    final List<String> imgList = [
      'https://cdn.shopify.com/s/files/1/0150/6262/products/the-sill_potted-plant_3-amaryllis-red-olaf-dormant-bulbs_prospect_sage-7_1500x.progressive.jpg?v=1544693095',
      'https://cdn.shopify.com/s/files/1/0150/6262/products/the-sill_Grant-Terracotta_Terracotta-7_1500x.progressive.jpg?v=1543604683',
      'https://cdn.shopify.com/s/files/1/0150/6262/products/Planter-Straight-on_Hyde-Terracotta_Terracotta-5_1500x.progressive.jpg?v=1544090618',
      'https://cdn.shopify.com/s/files/1/0150/6262/products/the-sill_Hyde-Terracotta_Terracotta-5_1500x.progressive.jpg?v=1543592246',
      'https://cdn.shopify.com/s/files/1/0150/6262/products/the-sill_potted-plant_pothos-jade-6_prospect_mustard-7_1500x.progressive.jpg?v=1541669485'
    ];

    return CarouselSlider(
      items: imgList.map((url) {
        return Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: 800.0,
                )));
      }).toList(),
      viewportFraction: 0.9,
      aspectRatio: 1,
      autoPlay: false,
    );
  }
}
