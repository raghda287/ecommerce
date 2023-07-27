import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/search_screen.dart';
import 'package:shop_app/modules/shop_app/shop_cubit.dart';
import 'package:shop_app/shared/components/component.dart';

class Shop_Layout extends StatelessWidget {
  const Shop_Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      builder: (BuildContext context, state) {
        var cubit =ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Sella'),
            actions: [IconButton(onPressed: (){navigateTo(context, Search_Screen(),);}, icon: Icon(Icons.search))],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar (
            onTap: (index){
              cubit.ChangeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,),

label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps,),
                label: 'Categories'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite,),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings,),
                label: 'Settings'
              ),
            ],

          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },
    );
  }
}
