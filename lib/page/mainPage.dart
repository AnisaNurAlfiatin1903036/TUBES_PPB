import 'package:evoting/model/calonKetua.dart';
import 'package:evoting/model/calonWakil.dart';
import 'package:evoting/page/login.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final String id;
  final int indexSelect;
  final bool isTapped;
  const MainPage(
      {Key? key, required this.id, this.indexSelect = 0, this.isTapped = true})
      : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<Widget> _widgetOptions() {
    return [
      FutureBuilder(
          future: CalonKetua.getKetua(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    List list = snapshot.data;

                    return CardCalon(
                      list: list,
                      index: index,
                      id: widget.id,
                      isCalonKetua: true,
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      FutureBuilder(
          future: CalonWakil.getWakil(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    List list = snapshot.data;

                    return CardCalon(
                      list: list,
                      index: index,
                      id: widget.id,
                      isCalonKetua: false,
                    );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account), label: 'Ketua'),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account_outlined), label: 'Wakil')
        ],
        currentIndex: widget.isTapped ? _selectedIndex : widget.indexSelect,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          'eVoting',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.dehaze,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
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
      drawer: Drawer(
        child: Container(
          color: Colors.lightBlueAccent,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  child: Center(
                child: Text(
                  "eVoting",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white),
                ),
              )),
              ListTile(
                onTap: () {
                  print("oke");
                },
                leading: Icon(
                  Icons.how_to_vote,
                  color: Colors.white,
                ),
                title: Text(
                  "Hasil Suara",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
      body: _widgetOptions().elementAt(widget.indexSelect),
    );
  }
}

class CardCalon extends StatelessWidget {
  const CardCalon(
      {Key? key,
      required this.list,
      required this.index,
      required this.id,
      required this.isCalonKetua})
      : super(key: key);

  final List list;
  final int index;
  final String id;
  final bool isCalonKetua;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/img/person.png'),
              width: 100,
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Text(
                    list[index].nama,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Konfirmasi'),
                                    content: Text(
                                        'Anda Yakin Untuk Memilih Kandidat Ini?'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.redAccent),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Tidak')),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.greenAccent),
                                          onPressed: () {
                                            if (isCalonKetua) {
                                              CalonKetua.postKetua(
                                                  id: id,
                                                  idCalon: list[index].id);

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          MainPage(
                                                            id: id,
                                                            indexSelect: 1,
                                                            isTapped: false,
                                                          )));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Anda Berhasil Memilih')));
                                            } else {
                                              CalonWakil.postWakil(
                                                  id: id,
                                                  idCalon: list[index].id);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          Login()));
                                              ;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Login Kembali Untuk Melihat Hasil Suara')));
                                            }
                                            ;
                                          },
                                          child: Text('Ya'))
                                    ],
                                  );
                                });
                          },
                          child: Text('Pilih')),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.amberAccent),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('PlatForm'),
                                    content: Text(list[index].platform),
                                  );
                                });
                          },
                          child: Text('PlatForm'))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
