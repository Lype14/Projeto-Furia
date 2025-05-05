import 'package:aplicativo_furia/app/services/OpenAiService.dart';
import 'package:aplicativo_furia/shared/constants/consts.dart';
import 'package:aplicativo_furia/shared/themes/colors.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_custom/dash_chat_custom.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60)),
    enableLog: true,
  );

  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'Luis', lastName: 'Felipe');
  final ChatUser _gptChatUser =
      ChatUser(id: '2', firstName: 'FURIA', lastName: 'Bot');

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];

  String? _assistantId;
  List<String> filesIds = ['file-XcwPCK2jfHkHQb6YDkG9V1'];

  @override
  void initState() {
    super.initState();
    initAssistant();
  }

  Future<void> initAssistant() async {
    final assistant = Assistant(
      model: Gpt4OModel(),
      name: 'FURIA Bot',
      instructions: BOT_ATENDENTE,
      tools: [
        {"type": "file_search"}
      ],
      fileIds: filesIds,
    );
    final response = await _openAI.assistant.v2.create(assistant: assistant);
    setState(() {
      _assistantId = response.id;
    });
    print("🧠 Assistant criado: $_assistantId");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DashChat(
        typingUsers: _typingUsers,
        currentUser: _currentUser,
        messageOptions: const MessageOptions(
          containerColor: textoBranco,
          textColor: primaryColor,
        ),
        onSend: (ChatMessage m) => getChatResponse(m),
        messages: _messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });

    if (_assistantId == null) return;

    List<Messages> messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();

    try {
      final thread = await _openAI.threads.v2.createThread(
        request: ThreadRequest(
          messages: messagesHistory.map((msg) => msg.toJson()).toList(),
        ),
      );

      final run = await _openAI.threads.v2.runs.createRun(
        threadId: thread.id,
        request: CreateRun(assistantId: _assistantId!),
      );

      while (true) {
        final runStatus = await _openAI.threads.v2.runs.retrieveRun(
          threadId: thread.id,
          runId: run.id,
        );
        if (runStatus.status == "completed") break;
        await Future.delayed(const Duration(seconds: 1));
      }

      final messages =
          await _openAI.threads.v2.messages.listMessage(threadId: thread.id);
      final assistantMsg =
          messages.data.firstWhere((msg) => msg.role == 'assistant');
      final content = assistantMsg.content.first.text!.value;

      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            text: content,
            user: _gptChatUser,
            createdAt: DateTime.now(),
          ),
        );
        _typingUsers.remove(_gptChatUser);
      });
    } catch (e) {
      print("⚠️ Erro ao buscar resposta: $e");
      _typingUsers.remove(_gptChatUser);
    }
  }
}
