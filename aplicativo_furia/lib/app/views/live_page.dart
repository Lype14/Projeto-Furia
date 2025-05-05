import 'package:aplicativo_furia/app/controllers/live_page_controller.dart';
import 'package:aplicativo_furia/shared/themes/colors.dart';
import 'package:aplicativo_furia/shared/themes/fonts.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dash_chat_custom/dash_chat_custom.dart';

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LivePageController(),
      child: Builder(builder: (context) {
        final LivePageController controller =
            Provider.of<LivePageController>(context);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: fundoSecundario,
              centerTitle: true,
              toolbarHeight: 100,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/furia_logo.png',
                            height: 55,
                          ),
                        ),
                        const SizedBox(width: 20), // Espaço maior entre logos
                        Text(
                          'VS',
                          style: ORBITRON(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(width: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/ence_logo2.png',
                            height: 55,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                   Text(
                      'FURIA x ENCE',
                      style: ORBITRON(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  // Player (parte de cima)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: YoutubePlayer(
                      controller: controller.controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.red,
                      ),
                    ),
                  ),

                  // Chat ocupa o restante e deixa input no fim
                  Expanded(
                    child: Container(
                      color: fundoSecundario,
                      child: DashChat(
                        currentUser: controller.currentUser,
                        messages: controller.messages,
                        onSend: (m) => controller.sendMessage(m),
                        typingUsers: controller.typingUsers,
                        messageOptions: const MessageOptions(
                          currentUserContainerColor: Colors.black,
                          containerColor: Color.fromRGBO(0, 166, 126, 1),
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      }),
    );
  }
}
