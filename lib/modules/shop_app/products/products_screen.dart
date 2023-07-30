
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../models/categories_model.dart';
import '../../../models/home_model.dart';
import '../../../shared/styles/colors.dart';
import '../shop_cubit.dart';


class Products_Screen extends StatelessWidget {
  const Products_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      builder: (context, State) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null ,
          builder: (context) => ProductsBuilder(cubit.homeModel,cubit.categoriesModel,context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, State) {},
    );
  }

  Widget ProductsBuilder(HomeModel? model,CategoriesModel ? categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),

            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categories',
                  style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w700),),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
  itemBuilder:(context,index)=> buildCategoriesItem(categoriesModel!.data!.data![index]),
  separatorBuilder: (BuildContext context,index)=>SizedBox(width: 10,) ,
  itemCount:categoriesModel!.data!.data!.length),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('New Products',
                    style: TextStyle(fontSize: 24,
                        fontWeight: FontWeight.w700),),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                childAspectRatio: 1.0 / 1.61,
                children: List.generate(model.data.products.length,
                    (index) => buildGridProduct(model.data.products[index],context)),
              ),
            ),
          ],
        ),
      );
  Widget buildGridProduct(ProductModel model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image.network(
                model.image,
                width: double.infinity,
                height: 200.0,
              ),
              if(model.discount !=0)
              Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text('DISCOUNT',style: TextStyle(fontSize: 8.0,color: Colors.white),),
                ),
              ),
            ],
          ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                            fontSize: 12.0, height: 1.3, color: defaultColor),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if(model.discount !=0)
                      Text(
                        '${model.old_price.round()}',
                        style: TextStyle(
                          fontSize: 10.0,
                          height: 1.3,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Spacer(),
                      CircleAvatar(
                        maxRadius: 15,
                        backgroundColor: ShopCubit.get(context).favourites![model.id]! ? Colors.blue:Colors.grey[200],
                        child: IconButton(
                            onPressed: (){

                              print(model.id);
                            }, icon: Icon(Icons.favorite_border,size: 14,)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  Widget buildCategoriesItem(DataModel model)=>Stack(
    alignment: Alignment.bottomCenter,
    children: [

    Image.network(
      model.image!,
      height: 100,
      width: 100,
      fit: BoxFit.cover,),

      Container(
        width: 100,
        color: Colors.black.withOpacity(0.7),
        child: Text(
          model.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(

            color: Colors.white,
        ),),
      ),
  ],);
}
