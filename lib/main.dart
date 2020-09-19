import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'Note.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatefulWidget {
  @override
  _XylophoneAppState createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  void playSound(int tone) {
    final player = AudioCache();
    //audio cache assumes note1.wav is already inside an assets folder
    player.play('note$tone.wav');
  }

  List<Note> noteList = new List(16);

  void playSong() {
    int delayCounter = 0;
    Duration delay = Duration(milliseconds: delayCounter);

    for (int i = 0; i < noteList.length; i++) {
      if (noteList[i].getTone() != 0) {
        int tone = noteList[i].getTone();
        Future.delayed(delay, () {
          playSound(tone);
        });
        //put a rest in between each note...somehow
      }
      delayCounter += 600;
      delay = Duration(milliseconds: delayCounter);
    }
  }

  Widget buildNoteHolder(int index) {
    if (noteList[index] == null) {
      noteList[index] = new Note(Colors.grey[300], 0);
    }
    return DragTarget<Note>(
      builder: (BuildContext context, List candidateData, List rejectedData) {
        return GestureDetector(
          onTap: () {
            setState(() {
              noteList[index] = new Note(Colors.grey[300], 0);
            });
          },
          child: Container(
            height: 60,
            width: 60,
            color: noteList[index].getColor(),
          ),
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (Note data) {
        setState(() {
          noteList[index].setColor(data.getColor());
          noteList[index].setTone(data.getTone());
        });
      },
    );
  }

  Widget buildKey(Color mahColor, int tone) {
    return Expanded(
      child: Draggable<Note>(
        child: Container(
          height: 200.0,
          child: FlatButton(
            onPressed: () {
              playSound(tone);
            },
            color: mahColor,
            child: null,
          ),
        ),
        feedback: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: mahColor,
            shape: BoxShape.circle,
          ),
        ),
        data: Note(mahColor, tone),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Xylophone'),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Drag notes into boxes to create a song',
                      ),
                      //place to drag notes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildNoteHolder(0),
                          buildNoteHolder(1),
                          buildNoteHolder(2),
                          buildNoteHolder(3),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildNoteHolder(4),
                          buildNoteHolder(5),
                          buildNoteHolder(6),
                          buildNoteHolder(7),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildNoteHolder(8),
                          buildNoteHolder(9),
                          buildNoteHolder(10),
                          buildNoteHolder(11),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildNoteHolder(12),
                          buildNoteHolder(13),
                          buildNoteHolder(14),
                          buildNoteHolder(15),
                        ],
                      ),
                      //button to play song
                      IconButton(
                        icon: Icon(
                          Icons.play_circle_filled,
                          size: 50.0,
                        ),
                        onPressed: () {
                          playSong();
                        },
                      )
                    ],
                  ),
                  color: Colors.white,
                  height: 600.0,
                  width: 400.0,
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    buildKey(Colors.red, 1),
                    buildKey(Colors.orange, 2),
                    buildKey(Colors.yellow, 3),
                    buildKey(Colors.green, 4),
                    buildKey(Colors.teal, 5),
                    buildKey(Colors.blue, 6),
                    buildKey(Colors.purple, 7),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
