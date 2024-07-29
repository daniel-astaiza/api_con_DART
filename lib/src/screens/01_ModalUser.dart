import 'package:api/src/controllers/ConsultarUsuarios.dart';
import 'package:flutter/material.dart';

void modalEventos(BuildContext context) {
  dynamic fetchUsers;
  consultarUsuarios().then((consultarUsuarios){
    fetchUsers = consultarUsuarios;


    showBottomSheet(
      context: context, 
      builder: (context){
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(padding: EdgeInsets.all(8),
              child: Icon(Icons.event),
              )
            ],
            backgroundColor: Colors.red[100],
            title: Text('Usuarios'),
          ),
          body: Center(
            child: Text(fetchUsers[0].name),
          ),
        );
      });

  });
  
}