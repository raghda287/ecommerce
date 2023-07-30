import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:serb/models/add_favourites.dart';
import 'package:serb/modules/shop_app/products/products_screen.dart';
import 'package:serb/modules/shop_app/settings/settings_screen.dart';

import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../shared/components/contants.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';
import 'cateogries/cateogries_screen.dart';
import 'favorites/favorites_screen.dart';


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

  Map<int,bool> ?favourites={};

  void getHomeData() async {
    emit(ShopLoadingHomeDataState());

    await DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) {
        favourites?.addAll({
          element.id: element.in_favorites,
        });
        print(favourites.toString());
      });
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

  AddFavouritesModel ? addFavouritesModel;
  void addFavourites(int product_id) async {
favourites?[product_id]!=favourites?[product_id];
emit(ShopSuccessAddFavouriteState());

    await DioHelper.postData(
      url: ADD_FAVOURITES,
      token: token, data: {
      "product_id":product_id,
    },
    ).then((value) {
      addFavouritesModel = AddFavouritesModel.fromJson(value.data);
print(value.data);


      emit(ShopSuccessAddFavouriteState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCAddFavouriteState());
    });
  }
}