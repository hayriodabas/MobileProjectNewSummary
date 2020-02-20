import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/core/model/projects.dart';
import 'package:flutterfire/core/model/student.dart';
import 'package:flutterfire/core/model/user.dart';
import 'package:flutterfire/core/services/firebase_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:auto_size_text/auto_size_text.dart';

final List<String> _hwHataListe = [
  "#158363",
  "#158560",
  "#158613",
  "#156123",
  "#168123",
];

final List<String> _swHataListe = [
  "#215312",
  "#234564",
  "#123456",
  "#321456",
];

class FireHomeView extends StatefulWidget {
  @override
  _FireHomeViewState createState() => _FireHomeViewState();
}

class _FireHomeViewState extends State<FireHomeView> {
  FirebaseService service;
  @override
  void initState() {
    super.initState();
    service = FirebaseService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        leading: Icon(Icons.home),
        centerTitle: true,
        title: Logo(), // 2
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              body:
              projectsFutureBuilder;
            },
          ),
        ],
      ),
      body: projectsFutureBuilder,
    );
  }
  //     body: Padding(
  //       padding: const EdgeInsets.only(top: 12.0),
  //       child: StaggeredGridView.count(
  //         crossAxisCount: 3,
  //         staggeredTiles: _staggeredTiles,
  //         // children: _tiles,
  //         mainAxisSpacing: 4.0,
  //         crossAxisSpacing: 4.0,
  //         padding: const EdgeInsets.all(4.0),
  //       ),
  //     ),
  //   );
  // }

  Widget get studentsBuilder => FutureBuilder<List<Student>>(
        future: service.getStudents(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // connectionState aktif mi , sıkıntılı mı , bekleme mi var
            case ConnectionState.done:
              if (snapshot.hasData)
                return _listStudent(snapshot.data);
              else
                return _notFoundWidget;
              break;
            default:
              return _waitingWidget;
          }
        },
      );

  Widget get userFutureBuilder => FutureBuilder<List<User>>(
        future: service.getUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData)
                return _listUser(snapshot.data);
              // return _listProject(snapshot.data);
              else
                return _notFoundWidget;
              break;
            default:
              return _waitingWidget;
          }
        },
      );
  Widget get projectsFutureBuilder => FutureBuilder<List<Projects>>(
        future: service.getProjects(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot
                  .hasData) //return new Center(child: new CircularProgressIndicator());
                return new StaggeredGridView.count(
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  padding: const EdgeInsets.all(4.0),
                  crossAxisCount: 3,
                  children: _listProject1(
                      snapshot.data), //buildGrid(snapshot.data.documents),
                  staggeredTiles: generateRandomTiles(snapshot.data.length),
                );
              else if (!snapshot.hasData) return _notFoundWidget;
              break;
            default:
              return _waitingWidget;
          }
        },
      );

  Widget _listUser(List<User> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => _userCard(list[index]));
  }

  Widget _listStudent(List<Student> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => _studentCard(list[index]));
  }

  Widget _listProject(List<Projects> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => _projectCard(list[index]));
  }

  List<Widget> _listProject1(List<Projects> list) {
    List<Widget> _gridItems = [];
    for (Projects project in list) {
      _gridItems.add(_projectCard(project));
    }
    return _gridItems;
  }

  Widget _userCard(User user) {
    return Card(
      child: ListTile(
        title: Text(user.name),
      ),
    );
  }

  Widget _studentCard(Student student) {
    return Card(
      child: ListTile(
        title: Text(student.name),
        subtitle: Text(student.number.toString()),
      ),
    );
  }

  List<StaggeredTile> generateRandomTiles(int count) {
    Random rnd = new Random();
    List<int> _staggeredTilesCrossAxis = [];
    _staggeredTilesCrossAxis.add(3);
    _staggeredTilesCrossAxis.add(1);
    _staggeredTilesCrossAxis.add(1);
    _staggeredTilesCrossAxis.add(1);
    _staggeredTilesCrossAxis.add(2);
    _staggeredTilesCrossAxis.add(1);
    _staggeredTilesCrossAxis.add(1);
    _staggeredTilesCrossAxis.add(1);
    _staggeredTilesCrossAxis.add(1);
    _staggeredTilesCrossAxis.add(1);
    _staggeredTilesCrossAxis.add(2);

    List<int> _staggeredTilesMainAxis = [];
    _staggeredTilesMainAxis.add(1);
    _staggeredTilesMainAxis.add(1);
    _staggeredTilesMainAxis.add(1);
    _staggeredTilesMainAxis.add(1);
    _staggeredTilesMainAxis.add(1);
    _staggeredTilesMainAxis.add(1);
    _staggeredTilesMainAxis.add(1);
    _staggeredTilesMainAxis.add(1);
    _staggeredTilesMainAxis.add(1);
    _staggeredTilesMainAxis.add(1);
    _staggeredTilesMainAxis.add(1);

    List<StaggeredTile> _staggeredTiles = [];
    for (int i = 0; i < count; i++) {
      _staggeredTiles.add(new StaggeredTile.count(
          _staggeredTilesCrossAxis[i % 11], _staggeredTilesMainAxis[i % 11]));
    }
    return _staggeredTiles;
  }
  // Widget _projectCard(Projects project) {
  //   return Card(
  //         color: backgroundColor,
  //         child: InkWell(
  //           onTap: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => projectDetail(),
  //                 ));
  //           },
  //           child: Center(
  //             child: Padding(
  //               padding: const EdgeInsets.all(4.0),
  //               child: Text(
  //                 project.projectName,
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );

  // return Card(
  //     // child: ListTile(
  //     //   title: Text(project.projectName),
  //     //   subtitle: Text(project.totalBug.toString()),
  //     // ),

  //   child: Container(
  //       child: Container(
  //         child:Column(children: <Widget>[
  //            Text(project.projectName)
  //            //,
  //           // Text(project.fixedBug.toString()),
  //           // Text(project.sWBug.toString()),
  //           // Text(project.hWBug.toString()),

  //         ],
  //         ),
  //       ),
  //     ),

  //   );
  // }

//   Widget _projectCard(Projects project) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       color: Colors.blue,
//       elevation: 10,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 12.0),
//         child: StaggeredGridView.count(
//           crossAxisCount: 3,
//           staggeredTiles: _staggeredTiles,
//           mainAxisSpacing: 4.0,
//           crossAxisSpacing: 4.0,
//           padding: const EdgeInsets.all(4.0),
//         ),
//       ),
//     );
//   }
//  }

//   // son listtile çalışan kod
//   Widget _projectCard(Projects project) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       color: Colors.blue,
//       elevation: 10,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ButtonTheme.bar(
//           child: ButtonBar(
//             alignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               Text(project.projectName,
//                   style: TextStyle(color: Colors.white, fontSize: 20)),
//               SizedBox(
//                 width: 60,
//               ),
//               FlatButton(
//                 child: const Text('Detaylar>',
//                     style: TextStyle(color: Colors.white)),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
  int _id;
  Widget _projectCard(Projects project) {
    return Card(
      color: Color(0xff95A9C6),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => projectDetail(project),
              ));
          debugPrint(project.projectName);
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              project.projectName,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget _projectCard(Projects project) {
//   return Card(
//   child: Container(
//       child: ListView.builder(
//          shrinkWrap: true,
//           itemCount: 1,
//           itemBuilder: (BuildContext ctxt, int index) {
//             return Container(
//         margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
//                 width: 25.0,
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                   color: Colors.blue,
//                   elevation: 10,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ButtonTheme.bar(
//                       child: ButtonBar(alignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[
//                           Text(project.projectName,
//                               style: TextStyle(color: Colors.white, fontSize: 20)),
//                           Text("Total:" + project.totalBug.toString(),
//                               style: TextStyle(color: Colors.white, fontSize: 10)),
//                           Text("HW:" + project.hWBug.toString(),
//                               style: TextStyle(color: Colors.white, fontSize: 10)),
//                           Text("SW:" + project.sWBug.toString(),
//                               style: TextStyle(color: Colors.white, fontSize: 10)),
//                           SizedBox(width: 30,),
//                           FlatButton(
//                             child: const Text('Detay>',
//                                 style: TextStyle(color: Colors.white)),
//                             onPressed: () {

//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//           }),
//     ),
//   );
// }

Widget get _notFoundWidget => Center(
      child: Text("Not Found"),
    );
Widget get _waitingWidget => Center(child: CircularProgressIndicator());

// }

class projectDetail extends StatelessWidget {
  Projects project;

  projectDetail(data) : this.project = data;
  String _backgroundImage;
  String _setImage() {
    if (project.productType.toString() == "bulasik") {
      _backgroundImage = "assets/images/bulasik1.png";
    } else if (project.productType.toString() == "buzdolabi") {
      _backgroundImage = "assets/images/buzdolabi1.png";
    } else if (project.productType.toString() == "camasir") {
      _backgroundImage = "assets/images/camasir1.png";
    } else if (project.productType.toString() == "cay") {
      _backgroundImage = "assets/images/cay1.png";
    } else if (project.productType.toString() == "davlumbaz") {
      _backgroundImage = "assets/images/davlumbaz1.png";
    } else if (project.productType.toString() == "diger") {
      _backgroundImage = "assets/images/diger1.png";
    } else if (project.productType.toString() == "firin") {
      _backgroundImage = "assets/images/firin1.png";
    } else if (project.productType.toString() == "kurutucu") {
      _backgroundImage = "assets/images/kurutucu1.png";
    } else if (project.productType.toString() == "ocak") {
      _backgroundImage = "assets/images/ocak1.png";
    } else {
      _backgroundImage = "assets/images/diger1.png";
    }

    // HG proje adına göre görsel
    if (project.projectName == "Smart home") {
      _backgroundImage = "assets/images/smarthome1.png";
    }
    print("_backgroundImage: $_backgroundImage");
    return _backgroundImage; // here it returns your _backgroundImage value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Proje Detayları"),
        /*actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {},
          ),
        ],*/
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new AssetImage(_setImage()) // not working
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                project.projectName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    color: Color(0xffE4EBF7),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.456,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText(
                              "MP DATE",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.017),
                              maxLines: 2,
                            ),
                            AutoSizeText(
                              project.mPDate,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.017),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    color: Color(0xffE4EBF7),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.456,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("İŞLETME",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.017)),
                            Text(project.source,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.017)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Card(
                  //   color: Colors.blueGrey[300],
                  //   elevation: 10,
                  //   child: Container(
                  //     width: 100,
                  //     height: 60,
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: <Widget>[
                  //         Text("KAYNAK", style: TextStyle(color: Colors.white)),
                  //         Text("M.ARGE", style: TextStyle(color: Colors.white)),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              /* SizedBox(
              height: 10,
            ), */

              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                child: Card(
                  color: Color(0xffBCCEEB),
                  elevation: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.93,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                          child: ListTile(
                            title: Text('YORUM',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Tahoma',
                                    fontSize: MediaQuery.of(context).size.height *
                                        0.018)),
                            subtitle: Text(project.yorum.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context).size.height *
                                        0.017)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35.0, 20.0, 0.0, 0.0),
                    child: Text(
                      "HardWare",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 20.0, 10.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            showAlertDialog(context);
                          },
                          child: Image.asset(
                            "assets/images/icons-05.png",
                            width: 20.0,
                            height: 20.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Card(
                        color: Color(0xff95A9C6),
                        elevation: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.29,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        hataDetail(project, 0),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  AutoSizeText(
                                    project.hWBug.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 40),
                                    maxLines: 2,
                                  ),
                                  Text(
                                    'OPEN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Color(0xff95A9C6),
                        elevation: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.29,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        hataDetail(project, 0),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    project.hWBug.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.05),
                                  ),
                                  Text(
                                    'FIXED',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Color(0xff95A9C6),
                        elevation: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.29,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        hataDetail(project, 1),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    project.sWBug.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.05),
                                  ),
                                  Text(
                                    'RC',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35.0, 10.0, 0.0, 0.0),
                    child: Text(
                      "SoftWare",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 10.0, 10.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            showAlertDialog(context);
                          },
                          child: Image.asset(
                            "assets/images/icons-05.png",
                            width: 20.0,
                            height: 20.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 6.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Card(
                        color: Color(0xff95A9C6),
                        elevation: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.29,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        hataDetail(project, 2),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    project.fixedBug.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.05),
                                  ),
                                  Text(
                                    'OPEN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Color(0xff95A9C6),
                        elevation: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.29,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        hataDetail(project, 3),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    project.rcBug.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.05),
                                  ),
                                  Text(
                                    'FIXED',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Color(0xff95A9C6),
                        elevation: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.29,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        hataDetail(project, 3),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    project.rcBug.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.05),
                                  ),
                                  Text(
                                    'RC',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Hataların güncellenme zamanı :" +
                    project.updateTime.toString(),
                style: TextStyle(fontSize: 14, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hata Kategorileri"),
      content: Column(
        children: <Widget>[
          Text(
            "Uygulamada yalnızca High ve Showstopper hatalar gösterilmektedir",
            style: TextStyle(fontSize: 12, color: Colors.red),
          ),
          Text(
            "OPEN: Kapatılmamış Hatalar",
            style: TextStyle(fontSize: 12),
          ),
          Text(
            "FIXED: Tasarım ekibinin çözdüğü, test ekibinin kontrol etmesi gereken, Açık Hatalar",
            style: TextStyle(fontSize: 12),
          ),
          Text(
            "RC: Seriye çıktıktan sonra çözülmesi konusunda anlaşılan, Açık Hatalar",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class hataDetail extends StatefulWidget {
  Projects project;
  int selected = 0;
  hataDetail(data, index)
      : this.project = data,
        this.selected = index;
  @override
  _hataDetailState createState() => _hataDetailState(project, selected);
}

class _hataDetailState extends State<hataDetail>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  Projects project;

  int selected = 0;
  _hataDetailState(data, index)
      : this.project = data,
        this.selected = index;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 6, vsync: this);
    _controller.animateTo(selected);
  }

  String _backgroundImage;

  String _setImage2() {
    if (project.productType.toString() == "bulasik") {
      _backgroundImage = "assets/images/bulasik2.png";
    } else if (project.productType.toString() == "buzdolabi") {
      _backgroundImage = "assets/images/buzdolabi2.png";
    } else if (project.productType.toString() == "camasir") {
      _backgroundImage = "assets/images/camasir2.png";
    } else if (project.productType.toString() == "cay") {
      _backgroundImage = "assets/images/cay2.png";
    } else if (project.productType.toString() == "davlumbaz") {
      _backgroundImage = "assets/images/davlumbaz2.png";
    } else if (project.productType.toString() == "diger") {
      _backgroundImage = "assets/images/diger2.png";
    } else if (project.productType.toString() == "firin") {
      _backgroundImage = "assets/images/firin2.png";
    } else if (project.productType.toString() == "kurutucu") {
      _backgroundImage = "assets/images/kurutucu2.png";
    } else if (project.productType.toString() == "ocak") {
      _backgroundImage = "assets/images/ocak2.png";
    } else {
      _backgroundImage = "assets/images/diger2.png";
    }
    // HG proje adına göre görsel
    if (project.projectName == "Smart home") {
      _backgroundImage = "assets/images/smarthome2.png";
    }
    print("_backgroundImage: $_backgroundImage");
    return _backgroundImage; // here it returns your _backgroundImage value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proje Hata Detayları'),
        centerTitle: true,
        elevation: 0.0,
        /* actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {},
          ),
        ],*/
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new AssetImage(_setImage2()) // not working
                            ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 40.0,
                            child: AutoSizeText(
                              project.projectName,
                              style: TextStyle(fontSize: 25.0),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 30.0,
                            child: AutoSizeText(
                              "MP Date: " + project.mPDate,
                              style: TextStyle(fontSize: 20.0),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 30.0,
                            child: AutoSizeText(
                              "İşletme: " + project.source,
                              style: TextStyle(fontSize: 20.0),
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: TabBar(
              isScrollable: true,
              controller: _controller,
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 70,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.info_outline,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text("HW OPEN")
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 70,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.info_outline,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text("HW FIXED")
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 70,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.info_outline,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text("HW RC")
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 70,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.info_outline,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text("SW OPEN")
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 70,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.info_outline,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text("SW FIXED")
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 70,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.info_outline,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text("SW RC")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.61,
            child: Container(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  Card(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: project.bugs.hWBug.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1.0, color: Colors.grey),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(project.bugs.hWBug[index].bugName),
                        );
                      },
                    ),
                  ),
                  Card(
                    child: ListView.separated(
                      itemCount: project.bugs.sWBug.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1.0, color: Colors.grey),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(project.bugs.sWBug[index].bugName),
                        );
                      },
                    ),
                  ),
                  Card(
                    child: ListView.separated(
                      itemCount: project.bugs.fixedBug.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1.0, color: Colors.grey),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(project.bugs.fixedBug[index].bugName),
                        );
                      },
                    ),
                  ),
                  Card(
                    child: ListView.separated(
                      itemCount: project.bugs.rcBug.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1.0, color: Colors.grey),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(project.bugs.rcBug[index].bugName),
                        );
                      },
                    ),
                  ),
                  Card(
                    child: ListView.separated(
                      itemCount: project.bugs.rcBug.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1.0, color: Colors.grey),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(project.bugs.rcBug[index].bugName),
                        );
                      },
                    ),
                  ),
                  Card(
                    child: ListView.separated(
                      itemCount: project.bugs.rcBug.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1.0, color: Colors.grey),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(project.bugs.rcBug[index].bugName),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // centers horizontally
      crossAxisAlignment: CrossAxisAlignment.center, // centers vertically
      children: <Widget>[
        Image.asset("assets/images/aquilalogo.png", width: 50),
        SizedBox(
          width: 0,
        ), // The size box provides an immediate spacing between the widgets
      ],
    );
  }
}
