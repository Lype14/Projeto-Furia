import 'package:aplicativo_furia/app/views/live_page.dart';
import 'package:aplicativo_furia/app/widgets/chat_page.dart';
import 'package:aplicativo_furia/shared/themes/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: fundoSecundario, // mesmo fundo da Live
        body: SafeArea(
          child: Column(
            children: [
               TabBar(
                indicatorColor: Colors.purpleAccent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: 'Live'),
                  Tab(text: 'Chat IA'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    LivePage(),
                    ChatWidget(),
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

