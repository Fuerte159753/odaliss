import 'package:flutter/material.dart';
import 'info.dart';


class PopularItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: [
            _buildCard(context, "Hamburgesa Doble", "images/burger.png", "\$10"),
            _buildCard(context, "Hamburgesa Doble", "images/burger.png", "\$10"),
            _buildCard(context, "Hamburgesa Doble", "images/burger.png", "\$10"),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String imagePath, String price) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InfoScreen(
                title: title,
                imagePath: imagePath,
                price: price,
              ),
            ),
          );
        },
        child: Container(
          width: 170,
          height: 245,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    imagePath,
                    height: 130,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                      size: 24,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}