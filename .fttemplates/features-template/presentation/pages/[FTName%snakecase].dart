import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';

class <FTName | pascalcase>Screen extends HookWidget {
  const <FTName | pascalcase>Screen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      // appBar: appAppBar(context, context.tr.<FTName | snakecase>),
      body: NetworkSensitive(
        child: Container()
      ),
    );
  }
}
