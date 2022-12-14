import 'package:http/http.dart' as http;
import 'package:seo_expart/model/product_model.dart';

class ServiceRequest {
  var apiUrl = 'https://fakestoreapi.com/';



  //load product 

  Future<List<ProductModel>?> featchPoducts() async {
    var url = Uri.parse("${apiUrl}products");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var productList = productModelFromJson(jsonString);
        print(productList.length);

        return productList;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //load cart for the user
  Future<List<ProductModel>?> featchCart(uid) async {
    var url = Uri.parse("${apiUrl}carts/user/$uid");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var productList = productModelFromJson(jsonString);
        print(productList.length);

        return productList;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }


}
