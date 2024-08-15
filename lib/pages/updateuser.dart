import 'package:flutter/material.dart';
import 'package:food_app/models/usuario.dart';
import 'package:food_app/base/base.dart';

class UpdateUser extends StatefulWidget {
  final int userId;

  const UpdateUser({Key? key, required this.userId}) : super(key: key);

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late Usuario _usuario;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final dbHelper = DatabaseHelper();
    final db = await dbHelper.database;

    // Obtener el usuario por ID
    final List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [widget.userId],
    );

    if (maps.isNotEmpty) {
      setState(() {
        _usuario = Usuario.fromMap(maps.first);
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUser() async {
    final dbHelper = DatabaseHelper();
    final db = await dbHelper.database;

    // Actualizar el usuario
    await db.update(
      'usuarios',
      _usuario.toMap(),
      where: 'id = ?',
      whereArgs: [widget.userId],
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Actualizar Usuario'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: _usuario.nombre,
              decoration: InputDecoration(labelText: 'Nombre'),
              onChanged: (value) {
                _usuario = _usuario.copyWith(nombre: value);
              },
            ),
            TextFormField(
              initialValue: _usuario.apellidos,
              decoration: InputDecoration(labelText: 'Apellidos'),
              onChanged: (value) {
                _usuario = _usuario.copyWith(apellidos: value);
              },
            ),
            TextFormField(
              initialValue: _usuario.correo,
              decoration: InputDecoration(labelText: 'Correo'),
              onChanged: (value) {
                _usuario = _usuario.copyWith(correo: value);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUser,
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}