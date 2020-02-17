import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutterfire/core/model/projects.dart';

import 'package:flutterfire/core/services/firebase_service.dart';

import 'fire_home_view.dart';

class history extends StatefulWidget {
  history({Key key, this.title}) : super(key: key);
  final String title;
  @override
  historyState createState() => historyState();
}

class historyState extends State<history> {
  void _incrementCounter() {
    setState(() {
    indexWeek = weekOfYear(DateTime.now()) + 1;
    indexWeekASC = 0;

      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
    });
  }

  void initState() {
    indexWeek = weekOfYear(DateTime.now()) + 1;
    indexWeekASC = 0;
    super.initState();
  }

  int indexWeek = weekOfYear(DateTime.now()) + 1;
  bool ascOrdesc = true;
  int indexWeekASC = 0;

  tapFn() {
    setState(() {
      //choice == true ? choiceTap = true : choiceTap = false;
      ascOrdesc = !ascOrdesc;
      indexWeek = weekOfYear(DateTime.now()) + 1;
      indexWeekASC = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 10.0,
          leading: Icon(Icons.history),
          centerTitle: true,
          title: Logo(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.sort_by_alpha),
              onPressed: () {
                tapFn();
              },
            ),
          ],
        ),
        body: getContainer(context, 0));
  }

  Container getContainer(BuildContext context, itemCount) {
    Container a = Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: weekOfYear(DateTime.now()),
          itemBuilder: (BuildContext ctxt, itemCount) {
            return Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              width: 25.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xff95A9C6),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme.bar(
                    child: ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("WEEK",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.height *
                                    0.025)),
                        Text((getIndex()).toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.height *
                                    0.025)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        FlatButton(
                          child: const Text('Geçmiş Detayları>',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => historyDetails(
                                      getIndexForRouting(itemCount)),
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
    );
    return a;
  }

  int getIndex() {
    if (indexWeek >= weekOfYear(DateTime.now()) + 1) {
      indexWeek = weekOfYear(DateTime.now()) + 1;
    }else if(indexWeek < 0){
      indexWeek = weekOfYear(DateTime.now()) + 1;
    }
    if (indexWeekASC <= 0) {
      indexWeekASC = 0;
    }else if(indexWeekASC > weekOfYear(DateTime.now()) + 1){
      indexWeekASC = 0;
    }
    if (ascOrdesc) {
      return getIndexDESC();
    } else {
      return getIndexASC();
    }
  }

  int getIndexForRouting(itemCount) {
    
    if (ascOrdesc) {
      return getIndexForRoutingDESC(itemCount);
    } else {
      return getIndexForRoutingASC(itemCount);
    }
  }

  int getIndexDESC() {


    indexWeek = indexWeek - 1;    
    if(indexWeek==1){
      indexWeek =  weekOfYear(DateTime.now()) + 1;
      return 1;
    }else
      return indexWeek;
  }

  int getIndexASC() {
    indexWeekASC = indexWeekASC + 1;
    if(indexWeekASC==weekOfYear(DateTime.now()) ){
      indexWeekASC =  0;
      return weekOfYear(DateTime.now()) ;
    }else
      return indexWeekASC;
  }

  int getIndexForRoutingDESC(itemCount) {
    return weekOfYear(DateTime.now()) - itemCount;
  }

  int getIndexForRoutingASC(itemCount) {
    return itemCount + 1;
  }

  static int weekOfYear(DateTime date) {
    DateTime monday = weekStart(date);
    DateTime first = weekYearStartDate(monday.year);

    int week = 1 + (monday.difference(first).inDays / 7).floor();

    if (week == 53 && DateTime(monday.year, 12, 31).weekday < 4) week = 1;
    debugPrint(week.toString());
    return week;
  }

  static DateTime weekStart(DateTime date) {
    // This is ugly, but to avoid problems with daylight saving
    DateTime monday = DateTime.utc(date.year, date.month, date.day);
    monday = monday.subtract(Duration(days: monday.weekday - 1));

    return monday;
  }

  static DateTime weekEnd(DateTime date) {
    // This is ugly, but to avoid problems with daylight saving
    // Set the last microsecond to really be the end of the week
    DateTime sunday =
        DateTime.utc(date.year, date.month, date.day, 23, 59, 59, 999, 999999);
    sunday = sunday.add(Duration(days: 7 - sunday.weekday));

    return sunday;
  }

  static DateTime weekYearStartDate(int year) {
    final firstDayOfYear = DateTime.utc(year, 1, 1);
    final dayOfWeek = firstDayOfYear.weekday;

    return firstDayOfYear.add(
        Duration(days: (dayOfWeek <= DateTime.thursday ? 1 : 8) - dayOfWeek));
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                index1=0;
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
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
        subtitle: Text("HW:" +
            project.hWBug.toString() +
            "   SW: " +
            project.sWBug.toString() +
            "   FixedBug:" +
            project.fixedBug.toString() +
            "   RCBug: " +
            project.rcBug.toString()),
      ),
    );
  }
}
