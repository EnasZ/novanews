import 'package:flutter/material.dart';

class OnBoardBody extends StatelessWidget {
  final String image ;
  final String title;
  final String subTitle;

  const OnBoardBody({super.key, required this.image, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage(image),height: 350,),
        SizedBox(height: 40),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xff4E4B66),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xff6E7191),
            ),
          ),
        ),
      ],
    );
  }
}
