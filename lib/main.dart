import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _songs;
  MusicFinder audioPlayer;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() async {
    audioPlayer = new MusicFinder();
    var songs = await MusicFinder.allSongs();
    songs = new List.from(songs);

    setState(() {
      _songs = songs;
    });
  }

  Future _playLocal(String url)async{
    final result = await audioPlayer.play(url, isLocal:true);
  }

  @override
  Widget build(BuildContext context) {  
    Widget home() {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Play Me'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: _songs.length,
          itemBuilder: (context, int index) {
            return new ListTile(
              leading: new CircleAvatar(
                child: new Text(_songs[index].title[0]),
              ),
              title: new Text(_songs[index].title),
              onTap: ()=>_playLocal(_songs[index].uri),
            );
          },
        ),
      );
    }

    return new MaterialApp(home: home());
  }
}
