import 'package:flutter/material.dart';
import 'package:flutterfire/core/model/projects.dart';
import 'package:flutterfire/ui/view/home/fire_home_view.dart';

import 'package:flutterfire/core/services/firebase_service.dart';

class history extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        centerTitle: true,
        title: Text("History"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {},
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 53,
            itemBuilder: (BuildContext ctxt, int index) {
              return Container(
                  margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  width: 25.0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.blue,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonTheme.bar(
                        child: ButtonBar(alignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("WEEK",
                                style: TextStyle(color: Colors.white, fontSize: 20)),
                            Text(index.toString(),
                                style: TextStyle(color: Colors.white, fontSize: 20)),
                            SizedBox(width: 60,),
                            FlatButton(
                              child: const Text('Geçmiş Detayları>',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                       builder: (context) => historyDetails(index),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
            }),
      ),
    );
  }
}

class historyDetails extends StatefulWidget {
    int index1;
  historyDetails(data) : this.index1 = data;

  @override
  _historyDetailsState createState() => _historyDetailsState(index1);
}

class _historyDetailsState extends State<historyDetails> {
  int index1;

  List<Projects> projectListGlobal_; 
  _historyDetailsState(data) : this.index1 = data;

  FirebaseService service;

  @override
  void initState() {
    super.initState();
    service = FirebaseService();
  }
  void _getSelectedRowInfo() {
      
      print('Selected Item Row Name Here...');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Week " + index1.toString()),
        elevation: 10.0,
        leading: Icon(Icons.history),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {},
          ),
        ],
      ),
      body: projectsFutureBuilder,
    );
  }
  
Widget get _notFoundWidget => Center(
      child: Text("Not Found"),
    );
Widget get _waitingWidget => Center(child: CircularProgressIndicator());

  Widget get projectsFutureBuilder => FutureBuilder<List<Projects>>(
        future: service.getProjectsForWeek(index1),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
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


  Widget _listStudent(List<Projects> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => _studentCard(list[index]));
  }
  
  Widget _studentCard(Projects project) {
    return Card(
      child: ListTile(
        title: Text(project.projectName),
        subtitle: Text("HW:" + project.hWBug.toString()  + "   SW: "+ project.sWBug.toString()+
        "   FixedBug:" + project.fixedBug .toString()  + "   Week: "+ project.week.toString()
        ),
      ),
    );
  }
}