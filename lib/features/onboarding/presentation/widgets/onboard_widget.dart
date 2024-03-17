import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';

class OnboardingPage extends StatelessWidget {

  final String description;
  final String imageUrl;

  OnboardingPage({ required this.description, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            imageUrl,
            height: 400,
            width:double.infinity,
            fit: BoxFit.cover,
          ),


          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(

              description,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: AppTextStyle.textStyleBoldBlackonboard,
            ),
          ),


        ],
      ),
    );
  }
}