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
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
          ),
          imageCarousel(),
          StreamBuilder(
            stream: plantDetailsBloc.name,
            builder: (context, snapshot) {
              return TextField(
                  onChanged: plantDetailsBloc.changeName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Give your plant a name", labelText: "Name"));
            },
          ),
          StreamBuilder(
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
          StreamBuilder(
            stream: plantDetailsBloc.wateringFrequency,
            builder: (context, snapshot) {
              return TextField(
                  onChanged: plantDetailsBloc.changeWateringFrequency,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "How often should to water this plant?",
                      labelText: "Water"));
            },
          ),
          RaisedButton(
            child: Text("Create"),
            color: Colors.white,
            onPressed: () {
              plantsProvider.addNewPlant();
              Navigator.pop(context);
            },
            elevation: 0,
          ),
        ],
      )),
    );
  }

  Widget imageCarousel() {
    final List<String> imgList = [
      'https://cdn.shopify.com/s/files/1/0150/6262/products/the-sill_potted-plant_3-amaryllis-red-olaf-dormant-bulbs_prospect_sage-7_1500x.progressive.jpg?v=1544693095',
      'https://cdn.shopify.com/s/files/1/0150/6262/products/the-sill_Grant-Terracotta_Terracotta-7_1500x.progressive.jpg?v=1543604683',
      'https://cdn.shopify.com/s/files/1/0150/6262/products/Planter-Straight-on_Hyde-Terracotta_Terracotta-5_1500x.progressive.jpg?v=1544090618',
      'https://cdn.shopify.com/s/files/1/0150/6262/products/Planter-Straight-on_Grant-Terracotta_Terracotta-5_1500x.progressive.jpg?v=1544090617',
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
