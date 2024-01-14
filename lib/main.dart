import 'package:assets_audio_player/assets_audio_player.dart';
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
  List<String> lstTitle = [
    'all-I-want-for-christmas',
    'christmas-bells',
    'christmas-holidays_medium',
    'jingle-bells-orchestra',
    'joyful-jingle',
    'last-christmas',
    'new-year-ambient-background',
    'o-holy-night',
    'we-wish-you-a-merry-christmas',
    'winter-forest-happy-merry-christmas',
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
          itemCount: lstTitle.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.white.withOpacity(0.3),
              child: ListTile(
                onTap: () {
                  assetsAudioPlayer.playlistPlayAtIndex(index);
                  setState(() {
                    currentPlayIndex = index;
                  });
                },
                title: getTitle(index),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          },
        )
      ]),
    );
  }

  Widget getTitle(int index) {
    if (currentPlayIndex == index) {
      return Text(
        lstTitle[index],
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      );
    }

    return Text(
      lstTitle[index],
      style: const TextStyle(color: Colors.white),
    );
  }
}
