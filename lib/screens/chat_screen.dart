import 'dart:io';
import 'package:appchat_flutter/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _txtController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isActive = false;
  final List<ChatMesssage> _messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Column(
            children: const <Widget>[
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                maxRadius: 14,
                child: Text(
                  'te',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Melizza Flores',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            color: Colors.white,
            height: 50,
            child: _inputChat(),
          ),
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _txtController,
              onSubmitted: _handleSubmit,
              onChanged: (texto) {
                setState(() {
                  if (texto.isNotEmpty) {
                    _isActive = true;
                  } else {
                    _isActive = false;
                  }
                });
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Enviar Mensaje',
              ),
              focusNode: _focusNode,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    onPressed: _isActive
                        ? () {
                            _handleSubmit(_txtController.text.trim());
                          }
                        : null,
                    child: const Text(
                      'Send',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: const IconThemeData(color: Colors.blue),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.send,
                          color: (_isActive ? Colors.blue : Colors.blue[400]),
                        ),
                        onPressed: _isActive
                            ? () {
                                _handleSubmit(_txtController.text);
                              }
                            : null,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    ));
  }

  _handleSubmit(String text) {
    if (text.isEmpty) return;
    _focusNode.requestFocus();
    _txtController.clear();
    final newMessage = ChatMesssage(
      text: text,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _isActive = false;
    });
  }
}
