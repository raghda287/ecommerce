import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/shop_app/cateogries/cateogries_screen.dart';
import 'package:shop_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shop_app/modules/shop_app/products/products_screen.dart';
import 'package:shop_app/modules/shop_app/settings/settings_screen.dart';
import 'package:shop_app/shared/components/contants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {

  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    Products_Screen(),
    Categories_Screen(),
    Favorites_Screen(),
    Settings_Screen(),

  ];

  void ChangeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

    HomeModel ? homeModel;


  void getHomeData() async {
    emit(ShopLoadingHomeDataState());

    await DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      //print(homeModel.data.banners[0].image);
      //print(homeModel.status);



      //print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
CategoriesModel ? categoriesModel;
  void getCategories() async {
    emit(ShopLoadingCategoriesState());

    await DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);





      //print(favorites.toString());

      emit(ShopErrorCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }
}