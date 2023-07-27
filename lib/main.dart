import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/shop_cubit.dart';
import 'package:shop_app/modules/shop_app/shop_layout/shop.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
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

        home: (Shop_Layout()),
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

