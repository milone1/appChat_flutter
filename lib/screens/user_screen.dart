import 'package:appchat_flutter/models/user.dart';
import 'package:appchat_flutter/services/auth_service.dart';
import 'package:appchat_flutter/services/chat_service.dart';
import 'package:appchat_flutter/services/socket_service.dart';
import 'package:appchat_flutter/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final userService = UserService();
  List<User> usuarios = [];

  @override
  void initState() {
    _chargueUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final user = authService.usuario;

    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              user.nombre,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.black54,
            ),
            onPressed: () {
              AuthService.deleteToken;
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
          actions: <Widget>[
            Container(
                margin: const EdgeInsets.only(right: 10),
                child: (socketService.serverStatus == ServerStatus.Online)
                    ? const Icon(Icons.check_circle_outline,
                        color: Colors.green)
                    : const Icon(Icons.check_circle_outline,
                        color: Colors.red)),
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _chargueUsers,
          header: const WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blueGrey,
            ),
            waterDropColor: Colors.blue,
          ),
          child: _listViewUser(),
        ));
  }

  ListView _listViewUser() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: ((context, index) => const Divider()),
      itemCount: usuarios.length,
      itemBuilder: ((context, index) => _usuarioListTile(usuarios[index])),
    );
  }

  ListTile _usuarioListTile(User usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        onTap: () {
          // print(usuario.nombre + usuario.email);
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.userFor = usuario;
          Navigator.pushNamed(context, 'chat');
        },
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(
            usuario.nombre.substring(0, 2),
          ),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: usuario.online ? Colors.green : Colors.red,
          ),
        ));
  }

  _chargueUsers() async {
    usuarios = await userService.getUsuarios();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
