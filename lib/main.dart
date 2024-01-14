import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:christmas_carols/music_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //음원 리스트
  final musicData = [
    {
      'title': 'all I want for christmas',
      'artist': 'Mariah Carey',
      'duration': '4:01',
      'albumImg': 'assets/images/all_i_want_for_cristmas.jpeg',
    },
    {
      'title': 'christmas bells',
      'artist': 'James Arthur',
      'duration': '4:06',
      'albumImg': 'assets/images/christmasBells.jpeg',
    },
    {
      'title': 'christmas holidays medium',
      'artist': 'Mariah Carey',
      'duration': '3:00',
      'albumImg': 'assets/images/all_i_want_for_cristmas.jpeg',
    },
    {
      'title': 'jingle bells orchestra',
      'artist': 'Mariah Carey',
      'duration': '00:56',
      'albumImg': 'assets/images/JingleBells.png',
    },
    {
      'title': 'joyful jingle',
      'artist': 'Mariah Carey',
      'duration': '00:56',
      'albumImg': 'assets/images/JingleBells.png',
    },
    {
      'title': 'last christmas',
      'artist': 'wham',
      'duration': '00:56',
      'albumImg': 'assets/images/lastChristmas.jpeg',
    },
    {
      'title': 'new year ambient background',
      'artist': 'Mariah Carey',
      'duration': '00:56',
      'albumImg': 'assets/images/all_i_want_for_cristmas.jpeg',
    },
    {
      'title': 'o holy night',
      'artist': 'Mariah Carey',
      'duration': '00:56',
      'albumImg': 'assets/images/all_i_want_for_cristmas.jpeg',
    },
  ];

  @override
  void initState() {
    // 음원연동
    assetsAudioPlayer.open(
        Playlist(
          audios: [
            Audio('assets/audios/all-I-want-for-christmas.mp3'),
            Audio('assets/audios/christmas-bells-171333.mp3'),
            Audio('assets/audios/christmas-holidays_medium-172984.mp3'),
            Audio('assets/audios/jingle-bells-orchestra_56sec-172985.mp3'),
            Audio('assets/audios/joyful-jingle-173919.mp3'),
            Audio('assets/audios/last-christmas.mp3'),
            Audio('assets/audios/new-year-ambient-background-174068.mp3'),
            Audio('assets/audios/o-holy-night-172276.mp3'),
            Audio(
                'assets/audios/we-wish-you-a-merry-christmas_60sec-174155.mp3'),
            Audio(
                'assets/audios/winter-forest-happy-merry-christmas-music-173777.mp3'),
          ],
        ),
        loopMode: LoopMode.playlist, //반복 재생 여부
        autoStart: false, //자동 재생
        showNotification: true,
        playInBackground: PlayInBackground.enabled //백그라운드 실행

        );
    super.initState();
  }

  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  int currentPlayIndex = -1;

  changeIndex(index) {
    setState(() {
      currentPlayIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Chrismas Carols',
          style: GoogleFonts.mountainsOfChristmas(
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          InkWell(
            child: const Icon(
              Icons.stop_circle_rounded,
              size: 24,
              color: Colors.white,
            ),
            onTap: () {
              assetsAudioPlayer.stop();
            },
          )
        ],
        shape: const Border(bottom: BorderSide(color: Colors.white, width: 1)),
      ),
      body: Stack(children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
            'https://th.bing.com/th/id/OIG.O5ADSyUTNHwOdytr15So?pid=ImgGn',
            fit: BoxFit.cover, // 가운데 기준으로 조금 당겨서 나온다.
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Lottie.network(
              "https://lottie.host/519939b8-3f22-4f03-9917-a13cd7cd0178/1kzQlHG2rq.json",
              fit: BoxFit.cover),
        ),
        //음원 재생 UI
        ListView.builder(
          itemCount: musicData.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.white.withOpacity(0.3),
              child: MusicTile(
                title: getTitle(index),
                artist: musicData[index]['artist'] as String,
                duration: musicData[index]['duration'] as String,
                albumImg: musicData[index]['albumImg'] as String,
                index: index,
                assetsAudioPlayer: assetsAudioPlayer,
                changeIndex: changeIndex,
              ),
            );
          },
        )
      ]),
    );
  }

  getTitle(int index) {
    if (currentPlayIndex == index) {
      return Text(
        musicData[index]['title'] as String,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      );
    }

    return Text(
      musicData[index]['title'] as String,
      style: const TextStyle(color: Colors.white),
    );
  }
}
