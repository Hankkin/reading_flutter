import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () => {Scaffold.of(context).openDrawer()},
                tooltip: 'Navigtation',
              ),
              title: new Text(
                'Reading',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.blue,
              elevation: 0,
              centerTitle: true,
              actions: <Widget>[
                IconButton( 
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              ]),
          body: new Center(
            child: new Text('首页'),
          ),
        ),
      );
}
