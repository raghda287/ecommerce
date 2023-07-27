class HomeModel{
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    data = HomeDataModel.formJson(json['data']);
  }
}

class HomeDataModel{
  late List<BannerModel> banners =[];
  late List<ProductModel> products =[];

  HomeDataModel.formJson(Map<String, dynamic> json){
    json['banners'].forEach((element){
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element){
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel{
  late int id;
  late String image;

  BannerModel.fromJson(Map<String , dynamic> json){
    id =json['id'];
    image =json['image'];
  }
}

class ProductModel{
  late int id;
  late dynamic price;
  late dynamic old_price;
  late dynamic discount;
  late String image;
  late String name;
  late bool in_favorites;
  late bool in_cart;

  ProductModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }

}