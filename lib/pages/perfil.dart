import 'package:flutter/material.dart';
import 'package:food_app/base/base.dart';
import 'package:food_app/models/usuario.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  late Future<Usuario?> _user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments is int) {
      final int userId = arguments;
      _user = _getUserById(userId);
    } else {
      // Maneja el caso en que los argumentos no sean un entero
      _user = Future.value(null);
    }
  }

  Future<Usuario?> _getUserById(int id) async {
    final dbHelper = DatabaseHelper();
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil del Usuario'),
      ),
      body: FutureBuilder<Usuario?>(
        future: _user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los datos.'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Usuario no encontrado.'));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre: ${user.nombre}', style: TextStyle(fontSize: 18)),
                  Text('Apellidos: ${user.apellidos}', style: TextStyle(fontSize: 18)),
                  Text('Correo: ${user.correo}', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}