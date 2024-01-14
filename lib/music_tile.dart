import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({
    super.key,
    required this.title,
    required this.artist,
    required this.duration,
    required this.albumImg,
    required this.index,
    required this.assetsAudioPlayer,
    required this.changeIndex,
  });

  final Text title;
  final String artist;
  final String duration;
  final String albumImg;
  final int index;
  final AssetsAudioPlayer assetsAudioPlayer;
  final Function changeIndex;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        assetsAudioPlayer.playlistPlayAtIndex(index);
        changeIndex(index);
      },
      leading: ClipRRect(
        child: Image.asset(
          albumImg,
          width: 50,
          height: 50,
        ),
      ),
      title: title,
      subtitle: Row(
        children: [
          const Icon(Icons.check_circle),
          SizedBox(),
          Flexible(
              child: Text(
            artist,
            maxLines: 1, //가수명 1줄까지만 보이게 하기
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey),
          )),
          SizedBox(),
          Text(duration, style: const TextStyle(color: Colors.grey)),
        ],
      ),
      trailing: const Icon(Icons.menu_outlined),
    );
  }
}
