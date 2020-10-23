import'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chess',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JustChess'),
      ),body: Center(
      child: Container(
        child:
          ChessBoard(
            onMove: (move)
            {
              print(move);
            },
            onCheckMate: (color)
            {
              print(color);
            },
            onDraw:() {
              print("DRAW!");
            } ,
            size: MediaQuery.of(context).size.width,
            enableUserMoves: true,
            boardType: BoardType.brown,
          ),
      ),
    ),
    );
  }
}


    
