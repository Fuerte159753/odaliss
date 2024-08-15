import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Widgets/AppBarWidget.dart';
import 'package:food_app/Widgets/CategoriesWidget.dart';
import 'package:food_app/Widgets/slidebar.dart';
import 'package:food_app/Widgets/tarjetas.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int userId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      drawer: SlideBar(userId: userId), // Agrega el Drawer aquí
      appBar: AppBar(
        title: Text("Food App"),
        automaticallyImplyLeading: false, // Evita que se muestre el icono del menú por defecto
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 0, // Ajusta la altura del AppBar si es necesario
        actions: [ // Agrega acciones si es necesario
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                // Implementa la acción para el ícono de la bolsa de compras aquí
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        children: [
          AppBarWidget(),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    CupertinoIcons.search,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "¿Qué quieres comer hoy?",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Categorías",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          CategoriesWidget(),

          Padding(
            padding: EdgeInsets.only(top: 20,left: 10),
            child: Text(
              "Popular",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            ),
            PopularItemsWidget(),
        ],
      ),
    );
  }
}
