import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/features/onboarding/presentation/widgets/onboard_widget.dart';
import 'package:shoplo_client/resources/images/images.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';
import 'package:shoplo_client/widgets/app_button.dart';
import 'package:shoplo_client/widgets/index.dart';

import '../../../../resources/colors/colors.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Widget> _pages = [
    OnboardingPage(
      description: 'احصل على تجربة توصيل سريعة وموثوقة في متناول يديك مع تطبيقنا الذي يغطي مناطق واسعة!',
      imageUrl: AppImages.onboar000, // Replace with your image
    ),
    OnboardingPage(

      description: 'احصل على تجربة توصيل فريدة وممتعة مع تطبيقنا الذي يوفر لك الوقت والجهد!',
      imageUrl: AppImages.onboard001, // Replace with your image
    ),
    OnboardingPage(

      description: 'اطلب بسهولة وتوصل بسرعة مع تطبيقنا الذي يوفر لك قائمة واسعة من المطاعم والمتاجر المحلية!',
      imageUrl: AppImages.onboar000, // Replace with your image
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              clipBehavior: Clip.none,
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return _pages[index];
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      _pages.length,
                          (index) => AnimatedContainer(
                        margin: EdgeInsets.only(right: 6),
                        duration: Duration(milliseconds: 300),
                        width: _currentPage==index?20:6,
                        height: 6,
                        decoration: BoxDecoration(
                          color:AppColors.primaryL,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.height*0.04,),
                AppButton(
                  onPressed: () {
                    if (_currentPage == _pages.length - 1) {
                      Navigator.of(context).pushNamed(AppRoutes.countries);
                      // Navigate to next screen or do something on last page

                    } else {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  title:
                    _currentPage == _pages.length - 1 ? 'Finish' : 'Next',
                  ),
                SizedBox(height: context.height*0.02,),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.countries);
                    // _pageController.previousPage(
                    //   duration: Duration(milliseconds: 500),
                    //   curve: Curves.ease,
                    // );
                  },
                  child: const Text(
                    'Skip',
                    style:AppTextStyle. textStyleButton2,
                  ),
                ),
              ],
            ),)
        ],
      ),
    );
  }
}