import 'package:flutter/material.dart';

class SlideBar extends StatefulWidget {
  final int userId;

  const SlideBar({required this.userId});
  @override
  _SlideBarState createState() => _SlideBarState();
}

class _SlideBarState extends State<SlideBar> {
  bool _isCategoriesExpanded = false; // Estado para controlar la expansión

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Icono en la parte superior
          UserAccountsDrawerHeader(
            accountName: Text("Nombre del Usuario"),
            accountEmail: Text("correo@ejemplo.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: 50,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.red, // Cambia el color de fondo si es necesario
            ),
          ),
          // Enlaces del menú
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/perfil',
                arguments: widget.userId,
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categorías'),
            onTap: () {
              setState(() {
                _isCategoriesExpanded = !_isCategoriesExpanded; // Cambia el estado
              });
            },
          ),
          if (_isCategoriesExpanded) ...[
            ListTile(
              leading: Icon(Icons.breakfast_dining),
              title: Text('Desayunos'),
              onTap: () {
                Navigator.pushNamed(context, '/desayunos'); // Define la ruta en tu archivo de rutas
                Navigator.pop(context); // Cierra el Drawer después de seleccionar
              },
            ),
            ListTile(
              leading: Icon(Icons.lunch_dining),
              title: Text('Comidas'),
              onTap: () {
                Navigator.pushNamed(context, '/comidas'); // Define la ruta en tu archivo de rutas
                Navigator.pop(context); // Cierra el Drawer después de seleccionar
              },
            ),
            ListTile(
              leading: Icon(Icons.dinner_dining),
              title: Text('Cenas'),
              onTap: () {
                Navigator.pushNamed(context, '/cenas'); // Define la ruta en tu archivo de rutas
                Navigator.pop(context); // Cierra el Drawer después de seleccionar
              },
            ),
            ListTile(
              leading: Icon(Icons.party_mode),
              title: Text('Fiestas'),
              onTap: () {
                Navigator.pushNamed(context, '/fiestas'); // Define la ruta en tu archivo de rutas
                Navigator.pop(context); // Cierra el Drawer después de seleccionar
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Exclusivo'),
              onTap: () {
                Navigator.pushNamed(context, '/exclusivo'); // Define la ruta en tu archivo de rutas
                Navigator.pop(context); // Cierra el Drawer después de seleccionar
              },
            ),
          ],
          ListTile(
              leading: Icon(Icons.person_2_outlined),
              title: Text('Lista de Usuarios'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                Navigator.pushNamed(context, '/listaUsuarios');
              },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar sesión'),
            onTap: () {
              // Implementa la lógica para cerrar sesión aquí
              Navigator.pop(context); // Cierra el Drawer
            },
          ),
        ],
      ),
    );
  }
}