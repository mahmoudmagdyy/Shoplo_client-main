import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> initDynamicLinks() async {
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    final Uri deepLink = dynamicLinkData.link;
    handlingDynamicLinks(deepLink);
    debugPrint('DEEP LINK 111: ${deepLink.path}', wrapWidth: 1024);
    debugPrint('DEEP LINK 222: $deepLink}', wrapWidth: 1024);
  }).onError((error) {
    // Handle errors
  });

  // Get any initial links
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  // AppSnackBar.showSuccess(
  //     NavigationService.navigatorKey.currentContext!, initialLink.toString());
  if (initialLink != null) {
    final Uri deepLink = initialLink.link;
    debugPrint('DEEP LINK 333: ${deepLink.path}', wrapWidth: 1024);
    debugPrint('DEEP LINK 444: $deepLink}', wrapWidth: 1024);
    // Example of using the dynamic link to push the user to a different screen
    handlingDynamicLinks(deepLink);
  }
}

void handlingDynamicLinks(Uri deepLink) {
  debugPrint(
      "🚀 ~ file: dynamic_links_service.dart ~ line 34 ~ void handlingDynamicLinks ~ $deepLink");
  if (deepLink.toString().contains('/advertisements/')) {
    // Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
    //   AppRoutes.adDetails,
    //   arguments: {
    //     'id': int.parse(deepLink.path.split('/')[4]),
    //     "isEdit": false,
    //   },
    // );
  }
  if (deepLink.toString().contains('/services/')) {
    // Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
    //   AppRoutes.serviceDetails,
    //   arguments: {
    //     'id': int.parse(deepLink.path.split('/')[4]),
    //     "isEdit": false,
    //   },
    // );
  }
}

Future<void> createDynamicLink(bool short, String link, String message) async {
  debugPrint(' DEEP LINK LINK: $link', wrapWidth: 1024);
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    // The Dynamic Link URI domain. You can view created URIs on your Firebase console
    uriPrefix: 'https://qimam.page.link',
    // The deep Link passed to your application which you can use to affect change
    link: Uri.parse(link),
    // Android application details needed for opening correct app on device/Play Store
    androidParameters: const AndroidParameters(
      packageName: 'com.fudex.qimam',
      minimumVersion: 1,
    ),
    // iOS application details needed for opening correct app on device/App Store
    iosParameters: const IOSParameters(
      appStoreId: '1605594217',
      bundleId: 'com.fudex.qimam',
      minimumVersion: '2',
    ),
  );

  final Uri uri;
  if (short) {
    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    uri = shortDynamicLink.shortUrl;
  } else {
    uri = await dynamicLinks.buildLink(parameters);
  }

  Share.share('$message \n\n$uri');
}

// open link as url . for launching a URL
void openURL(_url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
