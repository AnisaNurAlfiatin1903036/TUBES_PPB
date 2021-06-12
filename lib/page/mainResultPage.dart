import 'package:evoting/model/resultKetua.dart';
import 'package:evoting/model/resultSemua.dart';
import 'package:evoting/model/resultWakil.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class MainResultPage extends StatefulWidget {
  const MainResultPage({Key? key}) : super(key: key);

  @override
  _MainResultPageState createState() => _MainResultPageState();
}

class _MainResultPageState extends State<MainResultPage> {
  late ResultSemua getallvoter;

  late Future<List<ResultSemua>> getallvotes;

  String votes = '';

  getVotes() {
    ResultSemua.getAllVotes().then((value) =>
        {for (int i = 0; i < value.length; i++) votes = value[i].total});
  }

  int _selectedIndex = 0;

  List<Widget> _widgetOptions() {
    return [
      FutureBuilder(
          future: ResultSemua.getAllVoter(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    List data = snapshot.data;
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Hasil Keseluruhan",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Table(
                                children: [
                                  TableRow(children: <Widget>[
                                    Text(
                                      'Total Pemilih',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      ':',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      data[index].total,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    )
                                  ]),
                                  TableRow(children: [
                                    SizedBox(height: 15), //SizeBox Widget
                                    SizedBox(height: 15),
                                    SizedBox(height: 15),
                                  ]),
                                  TableRow(children: <Widget>[
                                    Text(
                                      'Suara Masuk',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      ':',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      (int.parse(votes) / 2).ceil().toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      FutureBuilder(
          future: ResultKetua.getAllVoter(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    List data = snapshot.data;
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                data[index].nama,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Table(
                                children: [
                                  TableRow(children: <Widget>[
                                    Text(
                                      'Suara Masuk',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      ':',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      data[index].total,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    ;
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      FutureBuilder(
          future: ResultWakil.getAllVoter(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    List data = snapshot.data;
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                data[index].nama,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Table(
                                children: [
                                  TableRow(children: <Widget>[
                                    Text(
                                      'Suara Masuk',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      ':',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      data[index].total,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    ;
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.how_to_vote), label: 'Semua'),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account), label: 'Ketua'),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account_outlined), label: 'Wakil')
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.how_to_vote,
          color: Colors.black,
        ),
        titleSpacing: 0,
        elevation: 0,
        title: Text(
          'Hasil Voting',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login()));
              },
              icon: Icon(
                Icons.logout,
                size: 20,
                color: Colors.black,
              ))
        ],
      ),
      body: _widgetOptions().elementAt(_selectedIndex),
    );
  }
}
