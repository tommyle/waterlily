import 'package:flutter/material.dart';
import './plants_provider.dart';
import '../../helpers/colors.dart';
import '../plant_details/plant_details_screen.dart';
import '../../components/common.dart';

class PlantsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final plantsBloc = PlantsProvider.of(context).plantsBloc;

    // DO NOT KEEP THIS HERE!!! FOR TESTING ONLY!!!
    plantsBloc.getPlants();

    return Scaffold(
      appBar: defaultAppBar("Waterlily"),
      floatingActionButton: addFloatingActionButton(plantsBloc, context),
      body: Container(
          child: Column(
        children: <Widget>[
          buildList(plantsBloc),
        ],
      )),
      backgroundColor: springWood,
    );
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

  Widget addFloatingActionButton(PlantsBloc bloc, BuildContext context) {
    return FloatingActionButton(
      // onPressed: () =>
      // bloc.addPlant("Justine's Plant", "Living Room", "assets/aloe.jpg"),
      onPressed: () { 
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlantDetailsScreen()),
        );
      },
      tooltip: 'Add Plant',
      child: Icon(Icons.add),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text(
        "Water Lily",
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
      ),
      brightness: Brightness.light, //Status bar text color
      elevation: 1,
      backgroundColor: desertStorm,
    );
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
          _plantInfo(plant.name, plant.location),
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

  Widget _plantInfo(String name, String location) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            Text("Mint", style: TextStyle(fontSize: 16, color: Colors.green)),
            Text(location,
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

// import 'dart:async';

// import 'package:flutter/material.dart';
// import './plants_provider.dart';
// import './plants_list.dart';

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _WaterContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       decoration: const BoxDecoration(
//         image: const DecorationImage(
//           fit: BoxFit.cover,
//           image: const AssetImage("assets/water.png"),
//         ),
//       ),
//     );
//   }
// }

// class _PlantCell extends StatelessWidget {
//   final String imageName;
//   final String name;

//   _PlantCell({this.imageName, this.name});

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//         margin: new EdgeInsets.only(top: 16, right: 16, left: 16),
//         decoration: new BoxDecoration(boxShadow: [
//           new BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10.0,
//           ),
//         ]),
//         child: new Row(
//           children: <Widget>[
//             new Expanded(
//               child: new _ImageContainer(imageName: imageName),
//               flex: 2,
//             ),
//             new Expanded(
//               child: new _InfoContainer(name: name),
//               flex: 3,
//             ),
//           ],
//         ),
//         constraints: BoxConstraints(maxHeight: 240, minHeight: 240));
//   }
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final StreamController<int> _streamController = StreamController<int>();
//   int _counter = 0;

//   @override
//   void dispose() {
//     _streamController.close();
//     super.dispose();
//   }

//   List<String> _plants = [];

//   void _addPlant(String name) {
//     // Only add the task if the user actually entered something
//     if (name.length > 0) {
//       setState(() => _plants.add(name));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(
//           widget.title,
//           style: TextStyle(
//               color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
//         ),
//         brightness: Brightness.light, //Status bar text color
//         elevation: 1,
//         backgroundColor: desertStorm,
//       ),
//       body: ListView.builder(
//         itemBuilder: (context, index) {
//           if (index < _plants.length) {
//             final imageName =
//                 index % 2 == 0 ? "assets/aloe.jpg" : "assets/lemonlime.jpg";
//             return _PlantCell(imageName: imageName, name: _plants[index]);
//           }
//         },
//       ),
//       backgroundColor: springWood,
//       floatingActionButton: FloatingActionButton(
//         onPressed: _pushAddTodoScreen,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
