import 'dart:io';
import 'package:appchat_flutter/models/message_response.dart';
import 'package:appchat_flutter/services/auth_service.dart';
import 'package:appchat_flutter/services/socket_service.dart';
import 'package:appchat_flutter/widgets/chat_message.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appchat_flutter/services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _txtController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isActive = false;
  List<ChatMesssage> _messages = [];
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('mensaje-personal', _listenMessage);
    _chargeMessages(chatService.userFor.uid);
  }

  void _chargeMessages(String userId) async {
    List<Message> chat = await chatService.getChat(userId);
    final history = chat.map((message) => ChatMesssage(
        text: message.message,
        uid: message.de.toString(),
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward()));

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _listenMessage(dynamic payload) {
    ChatMesssage newMessage = ChatMesssage(
        text: payload['message'],
        uid: payload['de'],
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 3)));
    setState(() {
      _messages.insert(0, newMessage);
    });
    newMessage.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userFor = chatService.userFor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                maxRadius: 14,
                child: Text(
                  userFor.nombre.toString().substring(0, 2),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                userFor.nombre,
                style: const TextStyle(
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
      uid: authService.usuario.uid,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _isActive = false;
    });
    socketService.emit('mensaje-personal', {
      'de': authService.usuario.uid,
      'para': chatService.userFor.uid,
      'message': text
    });
  }

  @override
  void dispose() {
    for (ChatMesssage messsage in _messages) {
      messsage.animationController.dispose();
    }
    socketService.socket.off('message-personal', _listenMessage);
    super.dispose();
  }
}
