import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serb/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:serb/shared/network/local/cache_helper.dart';
import 'package:serb/shared/network/remote/dio_helper.dart';

import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'modules/shop_app/shop_cubit.dart';
import 'modules/shop_app/shop_layout/shop.dart';

void main() {
  runApp(MyApp());
  DioHelper.init();
  CacheHelper.init();

}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategories()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        home: (OnBoardingScreen()),
        theme: ThemeData(
          primaryColor: Colors.blue,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            unselectedLabelStyle: TextStyle(color: Colors.grey),
            elevation: 20.0,
          ),
        ),
      ),
    );
  }
}

