import 'package:chat_gemini/Model/gemini_model.dart';
import 'package:chat_gemini/View/tools/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

class GeminiHome extends StatefulWidget {
  const GeminiHome({super.key});

  @override
  State<GeminiHome> createState() => _GeminiHomeState();
}

class _GeminiHomeState extends State<GeminiHome> {
  final TextEditingController txtController = TextEditingController();
  static const apiKey = "AIzaSyBKb98dM1QPANLo4LrM0ZIBmxl_RWHMIKY";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  final List<GeminiModel> prompt = [];

  Future<void> sendMessage() async {
    final message = txtController.text;
    //for prompt
    setState(() {
      txtController.clear();
      prompt.add(
        GeminiModel(
          isPrompt: true,
          message: message,
          time: DateTime.now(),
        ),
      );
    });

    //for responds

    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      prompt.add(
        GeminiModel(
          isPrompt: false,
          message: response.text ?? "",
          time: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text("Chat Bot", style: headStyle),
        actions: const [
          Icon(Icons.favorite_border),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: prompt.length,
                itemBuilder: (context, index) {
                  final message = prompt[index];
                  return UserPrompt(
                    isprompt: message.isPrompt,
                    message: message.message,
                    date: DateFormat('hh:mm a').format(message.time),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: txtController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: 'Ask me Something..?',
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 10),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 27,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container UserPrompt(
      {required final bool isprompt,
      required String message,
      required String date}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15)
          .copyWith(left: isprompt ? 80 : 15),
      decoration: BoxDecoration(
        color: isprompt ? Colors.black : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(25),
          topRight: const Radius.circular(25),
          bottomLeft: isprompt ? const Radius.circular(25) : Radius.zero,
          bottomRight: isprompt ? Radius.zero : const Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
//for prompt and respond

          Text(
            message,
            style: isprompt ? promptStyle : responseStyle,
          ),

          // for prompt and respond time
          Text(
            date,
            style: TextStyle(
              fontWeight: isprompt ? FontWeight.normal : FontWeight.normal,
              fontSize: 10,
              color: isprompt ? Colors.white60 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
