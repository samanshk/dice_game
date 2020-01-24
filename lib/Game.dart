import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Game extends StatefulWidget {
  String n1, n2;
  Game(this.n1, this.n2);
  @override
  _GameState createState() => _GameState(n1, n2);
}

class _GameState extends State<Game> {
  String p1Name;
  String p2Name;
  _GameState(this.p1Name, this.p2Name);

  static AudioCache player = AudioCache();
  var img1 = 'assets/blank.png';
  var img2 = 'assets/blank.png';

  // TextEditingController name1 = TextEditingController();
  // TextEditingController name2 = TextEditingController();

  String startText = 'Start';
  bool isStart = true;
  int time1 = 10, time2 = 10;
  int p1Chances = 10;
  int p1Score = 0;
  int p2Chances = 10;
  int p2Score = 0;
  bool active1 = false, active2 = false, noWinner = true;
  Color bgc1 = Colors.blueGrey[800], bgc2 = Colors.blueGrey[800];
  Timer timer;
  
  // initState() {
  //   super.initState();
  //   _playerRegister();
  //   setState(() {
  //     p1Name = name1.text;
  //     p2Name = name2.text;
  //   });
  // }

  restart() {
    time1 = 10; 
    time2 = 10;
    p1Chances = 10;
    p1Score = 0;
    p2Chances = 10;
    p2Score = 0;
    active1 = true; 
    active2 = false; 
    noWinner = true;
    bgc1 = Color(0xFF758AA2); 
    bgc2 = Colors.blueGrey[800];
    img1 = 'assets/dice1.png';
    img2 = 'assets/dice1.png';    
    setTimer();
  }
  
  startClick() {
    active1 = true;
    setState(() {
      startText = '';
      isStart = false;
      img1 = 'assets/dice1.png';
      img2 = 'assets/dice2.png';
      bgc1 = Color(0xFF758AA2);
    });
    setTimer();
  }
  
  setTimer() {
    if (p1Chances == 0 && p2Chances == 0) {
      time1 = 0;
      time1 = 0;
      bgc1 = Colors.blueGrey[800];
      bgc2 = Colors.blueGrey[800];

      if (p1Score > p2Score) {
        img1 = 'assets/winner.png';
        img2 = 'assets/lose.png';
        player.play('winner.wav');
        _showResult('Player 1 is the winner.', p1Score, p2Score);
      } else if(p2Score > p1Score) {
        img2 = 'assets/winner.png';
        img1 = 'assets/lose.png';
        player.play('winner.wav');
        _showResult('Player 2 is the winner.', p1Score, p2Score);
      } else {
        img2 = 'assets/draw.png';
        img1 = 'assets/draw.png';
        player.play('game_over.wav');
        _showResult('Draw', p1Score, p2Score);
      }
      return;
    }
    if (active1 && time1 > 0) {
      timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        setState(() {
          if(time1 == 0) {
            timer.cancel();
            p1Chances--;
            active1 = !active1;
            active2 = !active2;
            bgc1 = Colors.blueGrey[800];
            bgc2 = Color(0xFF758AA2);
            time2 = 10;
            setTimer();
          }
          else {
            if (time1 > 5) {
              player.play('timer.wav');
            } else {
              player.play('urgent_timer.wav');
            }
            time1--;
          }     
        });
      });
      
    } 
    else if (active2 && time2 > 0) {
      timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        setState(() {
          if(time2 == 0) {
            timer.cancel();
            p2Chances--;
            active1 = !active1;
            active2 = !active2;
            bgc2 = Colors.blueGrey[800];
            bgc1 = Color(0xFF758AA2);
            time1 = 10;
            setTimer();
          }          
          else {
            if (time2 > 5) {
              player.play('timer.wav');
            } else {
              player.play('urgent_timer.wav');
            }
            time2--;
          }
        });
      });
    }
    else {
      timer.cancel();
    } 
  }
  player1() {
    var r = Random().nextInt(6)+1;
    if (p1Chances > 0 && active1 == true) {
      setState(() {
        img1 = 'assets/dice$r.png';
        // p1Chances--;
        p1Score += r;
        player.play('dice.wav');
        // active2 = !active2;
        // active1 = !active1;
        time1 = 0;
      });      
    } 
    // else if (p1Score > p2Score && p1Chances == 0 && p2Chances == 0) {
    //   setState(() {
    //     img1 = 'assets/winner.png';  
    //   });      
    // }    
  }

  player2() {
    var r = Random().nextInt(6)+1;
    if (p2Chances > 0 && active2 == true) {
      setState(() {
        img2 = 'assets/dice$r.png';
        // p2Chances--;
        p2Score += r;
        player.play('dice.wav');
        // active2 = !active2;
        // active1 = !active1;
        time2 = 0;
      });      
    } 
    // else if (p2Score > p1Score && p1Chances == 0 && p2Chances == 0) {
    //   setState(() {
    //     img2 = 'assets/winner.png';  
    //   });      
    // } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[700],
        appBar: AppBar(
          title: Text('Dice Game'),
          backgroundColor: Colors.purple,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: bgc1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            '$p1Name',
                              style: TextStyle(color: Colors.white, fontSize: 25)
                          ),
                          Text(
                            '⏰ $time1',
                              style: TextStyle(color: Colors.white, fontSize: 25)
                          ),
                        ],
                      ),
                      
                      Padding(padding: EdgeInsets.all(9)),
                      MaterialButton(
                        onPressed: player1,
                        child: Image.asset(img1, height: 145, width: 145),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Chances Left: $p1Chances',
                            style: TextStyle(color: Colors.white, fontSize: 25)
                          ),
                          Padding(padding: EdgeInsets.all(40)),
                          Text(
                            'Score: $p1Score',
                            style: TextStyle(color: Colors.white, fontSize: 25)
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isStart,
                child: FlatButton(                
                  onPressed: startClick,
                  child: Text(
                    startText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: bgc2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            '$p2Name',
                              style: TextStyle(color: Colors.white, fontSize: 25)
                          ),
                          Text(
                            '⏰ $time2',
                              style: TextStyle(color: Colors.white, fontSize: 25)
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(9)),
                      MaterialButton(
                        onPressed: player2,
                        child: Image.asset(img2, height: 145, width: 145)
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Chances Left: $p2Chances',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          Padding(padding: EdgeInsets.all(40)),
                          Text(
                            'Score: $p2Score',
                            style: TextStyle(color: Colors.white, fontSize: 25)
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      
    );
  }

  Future<void> _showResult(result, s1, s2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(result, textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                result == 'Draw' ? Image.asset('assets/game.png', height: 100, width: 100,) : Image.asset('assets/winner.png', height: 100, width: 100), 
                Padding(padding: EdgeInsets.all(7)),
                Text('Scores', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
                Padding(padding: EdgeInsets.all(2)),
                Text('$p1Name score: $s1', textAlign: TextAlign.center,),
                Text('$p2Name score: $s2', textAlign: TextAlign.center),
                Padding(padding: EdgeInsets.all(10),),
                MaterialButton(
                  onPressed: () {
                    restart();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Restart',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  color: Colors.purple,
                ),
                MaterialButton(
                  onPressed: () {exit(0);},
                  child: Text(
                    'Quit',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  color: Colors.purple,
                )
              ],
            ),
          ),
        );
      },
    );
  }


  
}