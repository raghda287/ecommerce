import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Favorites_Screen extends StatelessWidget {
  const Favorites_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('favorite Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
