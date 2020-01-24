import 'package:flutter/material.dart';

import 'Game.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var player1 = TextEditingController();
  var player2 = TextEditingController();  
  String p1 = 'Player 1', p2 = 'Player 2';
  setNames() {
    setState(() {
      if (player1.text.isNotEmpty) {
        p1 = player1.text;
      }
      if (player2.text.isNotEmpty) {
        p2 = player2.text;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[700],
      // appBar: AppBar(
      //   title: Text('Dice Game'),
      // ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Dice Game', style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            Padding(padding: EdgeInsets.all(20),),
            Image.asset('assets/home.png', height: 150, width: 300,),
            Padding(padding: EdgeInsets.all(20),),
            TextField(
              controller: player1,
              decoration: InputDecoration(
                hintText: 'Player 1 name',
                filled: true,
                fillColor: Colors.white,
              ),
              maxLength: 7,
              enableInteractiveSelection: false,
            ),
            Padding(padding: EdgeInsets.all(15),),
            TextField(
              controller: player2,
              decoration: InputDecoration(
                hintText: 'Player 2 name',
                filled: true,
                fillColor: Colors.white,
              ),
              maxLength: 7,
              enableInteractiveSelection: false,
            ),
            Padding(padding: EdgeInsets.all(20),),
            MaterialButton(
              padding: EdgeInsets.all(10),
              onPressed: () {
                setNames();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Game(p1, p2)
                  )
                );
              },
              child: Text(
                'Enter',
                style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
              ),
              color: Colors.deepOrange,
            )
          ],
        )
      ),
    );
  }
}