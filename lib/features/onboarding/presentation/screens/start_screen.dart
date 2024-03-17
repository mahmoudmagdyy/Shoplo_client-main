
import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_router.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/resources/images/images.dart';
import 'package:shoplo_client/widgets/app_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            AppImages.delivarystart, // Replace this with your image path
            fit: BoxFit.cover,
          ),
          Center(
            child: Positioned(
              bottom: 30  ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    title: "start",
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.onBoardingRoute);
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),),
          )
          // Content

        ],
      ),
    );
  }
}
