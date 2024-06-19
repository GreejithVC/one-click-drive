import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:one_click_drive/constants/app_config.dart';
import 'package:one_click_drive/constants/app_styles.dart';
import 'package:one_click_drive/ui/chat_bot/message_widget.dart';
import 'package:one_click_drive/widgets/text_fields/custom_text_field.dart';

import '../../main.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late final GenerativeModel _model;
  late final ChatSession _chatSession;
  final FocusNode _textFieldFocus = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = GenerativeModel(model: "gemini-pro", apiKey: AppConfig.geminiApi);
    _chatSession = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat-Bot")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: ListView.builder(
                itemCount:_chatSession.history.length ,
            controller: _scrollController,
            itemBuilder: (context, index) {
              final Content content = _chatSession.history.toList()[index];
              final text = content.parts
                  .whereType<TextPart>()
                  .map<String>((e) => e.text)
                  .join("");
              return MessageWidget(
                  text: text, isFromUser: content.role == "user");
            },
            padding: EdgeInsets.all(8),
          )),
          Row(
            children: [
              Expanded(
                  child: TextField(
                autofocus: true,
                focusNode: _textFieldFocus,
                decoration: inputDecoration(),
                controller: _textEditingController,
                // onSubmitted: sendMessage,
              )),
              AppStyles.boxWidthLarge,
              _isLoading ? CircularProgressIndicator( ): IconButton(onPressed: ()=>sendMessage(_textEditingController.text), icon: Icon(  Icons.send))
            ],
          )
        ],
      ),
    );
  }

  Future<void> sendMessage(String message) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await _chatSession.sendMessage(Content.text(message));
      final text = response.text;
      if (text == null) {
        _showError("No response from API");
        return;
      } else {
        setState(() {
          _isLoading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _isLoading = false;
      });
    } finally {
      _textEditingController.clear();
      setState(() {
        _isLoading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _showError(String message) {
    showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Something went Wrong"),
            content: SingleChildScrollView(
              child: SelectableText(message),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 750), curve: Curves.easeInOutCirc);
      print("_scrollController.position.maxScrollExtent  ---- ${_scrollController.position.maxScrollExtent}");
    });
  }
  InputDecoration inputDecoration(){
    return InputDecoration(
      contentPadding: EdgeInsets.all(15),
      hintText: "Enter a prompt",
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10),),borderSide: BorderSide(color:Theme.of(navigatorKey.currentContext!).colorScheme.secondary)

      ),focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10),),borderSide: BorderSide(color:Theme.of(navigatorKey.currentContext!).colorScheme.secondary)

    )


    );

  }
}
