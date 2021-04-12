import 'package:flutter/material.dart';
import '../helpers/product.dart';
import '../models/products.dart';

class ProductProvider with ChangeNotifier{
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsByRestaurant = [];
  List<ProductModel> productsSearched = [];
  List<ProductModel> productsLeafy=[];
  List<ProductModel> productsroot=[];
  List<ProductModel> productsmarrow=[];
  List<ProductModel> productsstem=[];
  List<ProductModel> productsedible=[];
  List<ProductModel> productscruciferous=[];




  ProductProvider.initialize(){
    loadProducts();
  }

  loadProducts()async{
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({String categoryName})async{
    productsByCategory = await _productServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }



  Future loadProductByVegetables(String rest,String cate)async{
    switch(cate)
    {
      case "Leafy Green":
        productsLeafy=await _productServices.getProductsByRestCate(rest, cate);
        break;
      case "Root":
        productsroot=await _productServices.getProductsByRestCate(rest, cate);
        break;
      case "Marrow":
        productsmarrow=await _productServices.getProductsByRestCate(rest, cate);
        break;
      case "Stem":
        productsstem=await _productServices.getProductsByRestCate(rest, cate);
        break;
      case "Edible":
        productsedible=await _productServices.getProductsByRestCate(rest, cate);
        break;
      case "Cruciferous":
        productscruciferous=await _productServices.getProductsByRestCate(rest, cate);
        break;
    }

  }

  Future loadProductsByRestaurant({String restaurantId})async{
    productsByRestaurant = await _productServices.getProductsByRestaurant(id: restaurantId);
    notifyListeners();
  }

//  likeDislikeProduct({String userId, ProductModel product, bool liked})async{
//    if(liked){
//      if(product.userLikes.remove(userId)){
//        _productServices.likeOrDislikeProduct(id: product.id, userLikes: product.userLikes);
//      }else{
//        print("THE USER WA NOT REMOVED");
//      }
//    }else{
//
//      product.userLikes.add(userId);
//        _productServices.likeOrDislikeProduct(id: product.id, userLikes: product.userLikes);
//
//
//      }
//  }

  Future search({String productName})async{
    productsSearched = await _productServices.searchProducts(productName: productName);
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");

    notifyListeners();
  }


}