import 'package:flutter/material.dart';
import './plants_provider.dart';

class PlantsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = PlantsProvider.of(context);

    bloc.getPlants();

    return Scaffold(
        appBar: AppBar(title: Text('My Plants')), body: buildList(bloc));
  }

  Widget buildList(PlantsBloc bloc) {
    return StreamBuilder(
      stream: bloc.plants,
      builder: (context, AsyncSnapshot<List<Plant>> snapshot) {
        if (!snapshot.hasData) {
          return Text('No Plants');
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            final plant = snapshot.data[index];
            return Text(plant.name);
          },
        );
      },
    );
  }

  Widget addPlantButton(PlantsBloc bloc) {
    return RaisedButton(
        child: Text("Login"),
        color: Colors.blue,
        onPressed: bloc.addPlant("Justine's Plant", "Living Room", ""));
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

// class _ImageContainer extends StatelessWidget {
//   final String imageName;

//   _ImageContainer({this.imageName});

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.only(
//             topLeft: const Radius.circular(12.0),
//             bottomLeft: const Radius.circular(12.0)),
//         image: DecorationImage(
//           fit: BoxFit.cover,
//           image: AssetImage(this.imageName),
//         ),
//       ),
//     );
//   }
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

// class _WaterInfoContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       child: new Column(
//         children: <Widget>[
//           new Text("WATER IN", style: new TextStyle(fontSize: 18)),
//           new Text("12 Days",
//               style: new TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                   color: Colors.blueGrey)),
//         ],
//       ),
//     );
//   }
// }

// class _PlantInfo extends StatelessWidget {
//   final String name;

//   _PlantInfo({this.name});

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//         child: new Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             new Text(name,
//                 style:
//                     new TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
//             new Text("Mint",
//                 style: new TextStyle(fontSize: 16, color: Colors.green)),
//             new Text("Kitchen Window",
//                 style: new TextStyle(fontSize: 16, color: Colors.blueGrey)),
//           ],
//         ),
//         constraints: BoxConstraints(maxHeight: 90, minHeight: 90));
//   }
// }

// class _InfoContainer extends StatelessWidget {
//   final String name;

//   _InfoContainer({this.name});

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       padding: EdgeInsets.all(16),
//       decoration: const BoxDecoration(
//           borderRadius: const BorderRadius.only(
//               topRight: const Radius.circular(12.0),
//               bottomRight: const Radius.circular(12.0)),
//           color: Colors.white),
//       child: new Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           new _PlantInfo(name: name),
//           new Expanded(
//             child: Container(),
//           ),
//           new Container(
//             child: new Row(
//               children: <Widget>[
//                 new Expanded(
//                   child: Image.asset("assets/water.png"),
//                   flex: 1,
//                 ),
//                 new Expanded(
//                   child: new _WaterInfoContainer(),
//                   flex: 1,
//                 ),
//               ],
//             ),
//           )
//         ],
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

//   void _pushAddTodoScreen() {
//     // Push this page onto the stack
//     Navigator.of(context).push(
//         // MaterialPageRoute will automatically animate the screen entry, as well
//         // as adding a back button to close it
//         new MaterialPageRoute(builder: (context) {
//       return new Scaffold(
//           appBar: new AppBar(title: new Text('Add a new task')),
//           body: new TextField(
//             autofocus: true,
//             onSubmitted: (val) {
//               _addPlant(val);
//               Navigator.pop(context); // Close the add todo screen
//             },
//             decoration: new InputDecoration(
//                 hintText: 'Enter something to do...',
//                 contentPadding: const EdgeInsets.all(16.0)),
//           ));
//     }));
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
