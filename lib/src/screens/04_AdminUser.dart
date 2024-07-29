import 'package:api/src/screens/01_ModalUser.dart';
import 'package:api/src/screens/_ModalConsultarUsuarios.dart';
import 'package:flutter/material.dart';

class MenuUsers extends StatefulWidget {
  const MenuUsers({super.key});

  @override
  State<MenuUsers> createState() => _MenuUsersState();
}

class _MenuUsersState extends State<MenuUsers> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back , color: Colors.white ,),),
          title: Text(
            'Administrar Usuarios',
             style: TextStyle(color:Colors.white),
             ),
      ),
      body: ListView(
        children: [
          Image.network("https://cdn-icons-png.flaticon.com/512/1535/1535024.png",
          width: 300,
          height: 300,
          ),
          SizedBox(height: 16.0,),
          ListTile(
            title: Text('Buscar Usuarios'),
            leading: Icon(Icons.connect_without_contact),
            trailing: Icon(Icons.arrow_circle_right_outlined),
            onTap: () {},
          ),
          ListTile(
            title: Text('Usuarios'),
            leading: Icon(Icons.account_circle),
            trailing: Icon(Icons.social_distance_outlined),
            onTap: () {
               modalEventos(context);
            },
          ),
          ListTile(
            title: Text('Solicitudes'),
            leading: Icon(Icons.message_sharp),
            trailing: Icon(Icons.airplay_rounded),
            onTap: () {},
          ),
          ListTile(
            title: Text('Informes'),
            leading: Icon(Icons.devices_outlined),
            trailing: Icon(Icons.edit_document),
            onTap: () {
            },
          )
        ],
      ),
    ); 
  }
}
