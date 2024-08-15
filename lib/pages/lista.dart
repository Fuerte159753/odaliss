import 'package:flutter/material.dart';
import 'package:food_app/models/usuario.dart';
import 'package:food_app/base/base.dart';
import 'package:food_app/pages/updateuser.dart'; // Asegúrate de importar la página de actualización

class ListaUsuarios extends StatefulWidget {
  @override
  _ListaUsuariosState createState() => _ListaUsuariosState();
}

class _ListaUsuariosState extends State<ListaUsuarios> {
  List<Usuario> _usuarios = [];

  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  // Función para cargar los usuarios desde la base de datos
  Future<void> _cargarUsuarios() async {
    final dbHelper = DatabaseHelper();
    final db = await dbHelper.database;

    // Realizar la consulta para obtener los usuarios
    final List<Map<String, dynamic>> maps = await db.query('usuarios');

    // Convertir la lista de mapas a una lista de objetos Usuario
    setState(() {
      _usuarios = List.generate(maps.length, (i) {
        return Usuario.fromMap(maps[i]);
      });
    });
  }

  // Función para eliminar un usuario
  Future<void> _eliminarUsuario(int id) async {
    final dbHelper = DatabaseHelper();
    final db = await dbHelper.database;
    await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
    _cargarUsuarios(); // Recargar la lista de usuarios
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Correo')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: _usuarios.map((usuario) {
                return DataRow(
                  cells: [
                    DataCell(Text('${usuario.nombre} ${usuario.apellidos}')),
                    DataCell(Text(usuario.correo)),
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Navegar a la página de edición con el ID del usuario
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateUser(userId: usuario.id!),
                                ),
                              );
                            },
                          ),
                          // Aquí se podría agregar más acciones si es necesario
                        ],
                      ),
                    ),
                  ],
                  onSelectChanged: (selected) {
                    if (selected != null && selected) {
                      // Si se hace clic en una fila, mostrar detalles u otra acción
                    }
                  },
                  onLongPress: () {
                    // Acciones de largo presionado en la fila
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}