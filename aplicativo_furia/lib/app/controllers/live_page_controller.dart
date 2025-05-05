import 'package:aplicativo_furia/shared/constants/consts.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_custom/dash_chat_custom.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LivePageController with ChangeNotifier {
  late final String videoId;
  late final YoutubePlayerController controller;
  final ChatUser currentUser =
      ChatUser(id: '1', firstName: 'Luis', lastName: 'Felipe');
  List<ChatMessage> messages = <ChatMessage>[];
  List<ChatUser> typingUsers = <ChatUser>[];

  Future<void> sendMessage(ChatMessage m) async {
    typingUsers.add(m.user);
    messages.insert(0, m);
    typingUsers.remove(m.user);
    notifyListeners();
  }

  LivePageController() {
    videoId = YoutubePlayer.convertUrlToId(
        "https://www.youtube.com/watch?v=FTbdr8v-UDs")!;
    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }
}
