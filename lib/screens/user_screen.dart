import 'package:appchat_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserScreen extends StatefulWidget {
  UserScreen({super.key});
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuarios = [
    User(online: true, email: 'juan@gmail.com', name: 'Juan', uid: '1'),
    User(online: false, email: 'jua1@gmail.com', name: 'Mari', uid: '2'),
    User(online: true, email: 'jua2@gmail.com', name: 'Ludo', uid: '3'),
    User(online: false, email: 'jua3@gmail.com', name: 'Buda', uid: '4'),
    User(online: true, email: 'jua4@gmail.com', name: 'Jose', uid: '5'),
    User(online: false, email: 'jua5@gmail.com', name: 'Laun', uid: '6'),
    User(online: true, email: 'jua6@gmail.com', name: 'Jean', uid: '7'),
    User(online: false, email: 'jua7@gmail.com', name: 'Juis', uid: '8'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
    User(online: true, email: 'jua8@gmail.com', name: 'Kilo', uid: '9'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "USUARIO NAME",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.black54,
            ),
            onPressed: () {},
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.blue,
              ),
            ),
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
        title: Text(usuario.name),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(
            usuario.name.substring(0, 2),
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
    await Future.delayed(const Duration(milliseconds: 3000));
    _refreshController.refreshCompleted();
  }
}
