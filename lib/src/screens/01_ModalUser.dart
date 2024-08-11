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
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _showEliminarUsuario(
                              context,
                              usuario.id,
                              () async {
                                try {
                                  await eliminarUsuario(usuario.id);
                                  Navigator.of(context).pop(); // Cierra el modal
                                  ModalUsuariosFetch(context); // Vuelve a cargar la lista de usuarios
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error al eliminar usuario')),
                                  );
                                }
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.update, color: Colors.blue),
                          onPressed: () {
                            _showActualizarUsuario(context, usuario);
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

void _showEliminarUsuario(BuildContext context, String? userId, VoidCallback onDeleteConfirmed) {
  if (userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('ID de usuario no válido')),
    );
    return;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirmar eliminación"),
        content: Text("¿Está seguro de que desea eliminar este usuario?"),
        actions: [
          TextButton(
            child: Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Eliminar"),
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
              onDeleteConfirmed(); // Llama a la función para eliminar el usuario
            },
          ),
        ],
      );
    },
  );
}

void _showActualizarUsuario(BuildContext context, Users usuario) {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: usuario.name);
  final _emailController = TextEditingController(text: usuario.email);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Actualizar Usuario"),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nombre"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Correo electrónico"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un correo electrónico';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Actualizar"),
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                try {
                  await updateUser(
                    usuario.id,
                    _nameController.text,
                    _emailController.text,
                  );
                  Navigator.of(context).pop(); // Cierra el diálogo
                  ModalUsuariosFetch(context); // Vuelve a cargar la lista de usuarios
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al actualizar usuario: $e')),
                  );
                }
              }
            },
          ),
        ],
      );
    },
  );
}
