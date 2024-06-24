import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'widgets/chat_bubble.dart';

const apiKey = 'AIzaSyBORmgOMU8vBQlVPqzlQliYmcxPwv8Y6ow';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );

  TextEditingController messageController = TextEditingController();

  bool isLoading = false;

  List<ChatBubble> chatBubbles = [
    const ChatBubble(
      direction: Direction.left,
      message: 'Hallo saya Gemini AI. Ada yang bisa saya bantu?',
      photoUrl: 'https://i.pravatar.cc/150?img=47',
      type: BubbleType.alone,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoButton(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ChatPage();
            }));
          }),
        ),
        title: const Text('Gemini Personal Assistant AI',
            style: TextStyle(color: Colors.blueGrey)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              reverse: true,
              padding: const EdgeInsets.all(10),
              children: chatBubbles.reversed.toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : IconButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          final content = [
                            Content.text(messageController.text)
                          ];
                          final GenerateContentResponse responseAI =
                              await model.generateContent(content);
                          chatBubbles = [
                            ...chatBubbles,
                            ChatBubble(
                              direction: Direction.right,
                              message: messageController.text,
                              photoUrl: null,
                              type: BubbleType.alone,
                            ),
                          ];

                          chatBubbles = [
                            ...chatBubbles,
                            ChatBubble(
                              direction: Direction.left,
                              message:
                                  responseAI.text ?? 'Maaf saya tidak mengerti',
                              photoUrl: 'https://i.pravatar.cc/150?img=47',
                              type: BubbleType.alone,
                            ),
                          ];
                          messageController.clear();
                          setState(() {
                            isLoading = false;
                          });
                        },
                        icon: const Icon(Icons.send),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
