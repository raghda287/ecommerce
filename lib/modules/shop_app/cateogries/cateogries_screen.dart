import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/modules/shop_app/shop_cubit.dart';

class Categories_Screen extends StatelessWidget {
  const Categories_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      builder: (context, index) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildCatItem(
            ShopCubit.get(context).categoriesModel!.data!.data![index]),
        separatorBuilder: (context, index) => Divider(),
        itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length,
      ),
      listener: (context, index) {},
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image.network(
              model.image!,
              height: 80.0,
              width: 80.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              model.name!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      );
}
