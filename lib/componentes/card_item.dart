import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  String image, title;
  VoidCallback? onTap;

  CardItem({
    Key? key,
    required this.image,
    required this.title,
    this.onTap,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.all(15),
        child: Column(children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset("assets/images/" + image),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
