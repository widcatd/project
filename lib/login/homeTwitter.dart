import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:project/blocks/auth_block.dart';
// import 'package:project/blocks/auth_block_google.dart';
import 'package:project/login/log.dart';
import 'package:provider/provider.dart';

class HomeScreen2 extends StatefulWidget {
  @override
  _HomeScreenState2 createState() => _HomeScreenState2();
}

class _HomeScreenState2 extends State<HomeScreen2> {
  StreamSubscription<User> loginTStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginTStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Loginpage(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginTStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);

    return Scaffold(
      appBar: new AppBar(
        title: Text("alerta arequipa"),
        backgroundColor: Colors.blue,
      ),
      body: Container(),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(authBloc.nick),
              accountEmail: new Text(authBloc.correo),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(authBloc.foto),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Perfil"),
            ),
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text("Cambiar contraseña"),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("info"),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Salir de la aplicacion"),
            )
          ],
        ),
      ),
    );
  }
}
