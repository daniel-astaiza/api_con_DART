
// import 'package:flutter/material.dart';
// import 'package:api/src/controllers/ConsultarUsuarios.dart';

// void ModalUsuariosFetch(BuildContext context) {
//   consultarUsuarios().then((usuarios) {
//     if (usuarios != null && usuarios.isNotEmpty) {
//       showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Usuarios'),
//             actions: [
//               Padding(padding: EdgeInsets.all(8),
//               child: Icon(Icons.event),
//               )
//             ],
//             backgroundColor: Colors.red[100],
//             ),
//             body: ListView.builder(
//               itemCount: usuarios.length,
//               itemBuilder: (context, index) {
//                 final usuario = usuarios[index];
//                 return Card(
//                   margin: EdgeInsets.all(8.0),
//                   elevation: 4.0,
//                   child: ListTile(
//                     contentPadding: EdgeInsets.all(16.0),
//                     title: Text(usuario.name), 
//                     subtitle: Text(usuario.email), 
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       );
//     }
//   });
// }
import 'package:flutter/material.dart';
import 'package:api/src/controllers/ConsultarUsuarios.dart';

void ModalUsuariosFetch(BuildContext context) {
  consultarUsuarios().then((usuarios) {
    if (usuarios != null && usuarios.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Usuarios'),
              actions: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.event),
                ),
              ],
              backgroundColor: Colors.red[100],
            ),
            body: ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final usuario = usuarios[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4.0,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(usuario.name),
                    subtitle: Text(usuario.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {

                            
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                           
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    }
  });
}


