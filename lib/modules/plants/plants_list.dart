import 'package:flutter/material.dart';
import './plants_provider.dart';

class PlantsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = PlantsProvider.of(context);

    bloc.getPlants();

    return Container(
        child: Column(
          children: <Widget>[
            buildList(bloc),
            addPlantButton(bloc)
          ],
        ));
  }

  Widget buildList(PlantsBloc bloc) {
    return StreamBuilder(
      stream: bloc.plants,
      builder: (context, AsyncSnapshot<List<Plant>> snapshot) {
        if (!snapshot.hasData) {
          return Text('No Plants');
        }

        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final plant = snapshot.data[index];
              return _PlantCell(
                plant: plant,
              );
            },
          ),
        );
      },
    );
  }

  Widget addPlantButton(PlantsBloc bloc) {
    return RaisedButton(
        child: Text("Add Plants"),
        color: Colors.blue,
        onPressed: () =>
            bloc.addPlant("Justine's Plant", "Living Room", "assets/aloe.jpg"));
  }
}

class _PlantCell extends StatelessWidget {
  final Plant plant;

  _PlantCell({this.plant});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16, right: 16, left: 16),
        decoration: BoxDecoration(boxShadow: [
         BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
          ),
        ]),
        child: Row(
          children: <Widget>[
           Expanded(
              child: _imageContainer(plant.imagePath),
              flex: 2,
            ),
           Expanded(
              child: _infoContainer(),
              flex: 3,
            ),
          ],
        ),
        constraints: BoxConstraints(maxHeight: 240, minHeight: 240));
  }

  Widget _imageContainer(imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(12.0),
            bottomLeft: const Radius.circular(12.0)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }

  Widget _infoContainer() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: const BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: const Radius.circular(12.0),
              bottomRight: const Radius.circular(12.0)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _plantInfo(plant.name),
         Expanded(
            child: Container(),
          ),
         Container(
            child: Row(
              children: <Widget>[
                 Expanded(
                  child: Image.asset("assets/water.png"),
                  flex: 1,
                ),
                 Expanded(
                  child: _waterInfoContainer(),
                  flex: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _plantInfo(String name) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
           Text(name,
                style:
                   TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
           Text("Mint",
                style: TextStyle(fontSize: 16, color: Colors.green)),
           Text("Kitchen Window",
                style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          ],
        ),
        constraints: BoxConstraints(maxHeight: 90, minHeight: 90));
  }

  Widget _waterInfoContainer() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("WATER IN", style: TextStyle(fontSize: 18)),
          Text("12 Days",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blueGrey)),
        ],
      ),
    );
  }
}