import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  final String title;
  final String imagePath;
  final String price;

  InfoScreen({
    required this.title,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                imagePath,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Hamburgesa hecha con la mas alta calidad, disfruta de una y deleita tu paladar",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              price,
              style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implementa la lógica para agregar al carrito
                },
                child: Text('Agregar al Carrito'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
