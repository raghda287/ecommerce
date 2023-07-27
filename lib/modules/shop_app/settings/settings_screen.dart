import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings_Screen extends StatelessWidget {
  const Settings_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('setting Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
