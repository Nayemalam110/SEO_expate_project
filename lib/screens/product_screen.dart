import 'package:flutter/material.dart';
import 'package:seo_expart/model/product_model.dart';
import 'package:seo_expart/service/service_request.dart';
import 'package:seo_expart/widgets/single_product.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController editingController = TextEditingController();

  List<ProductModel>? productData;
  List<ProductModel>? SearchList;
  bool flag = true;
  var items;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void filterSearchResults(String query) {
    List<ProductModel>? searchList;
    searchList!.addAll(productData!);
    if (query.isNotEmpty) {
      List<ProductModel>? newList;
      searchList.forEach((item) {
        if (item.title!.contains(query)) {
          newList!.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(newList);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(productData);
      });
    }
  }

  void loadData() async {
    ServiceRequest().featchPoducts().then((value) {
      productData = value;
      setState(() {
        setState(() {
          flag = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              suffixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 2 / 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 10,
                  itemBuilder: ((context, index) =>
                      SingleProduct(productData![index])))),
        ]),
      )),
    );
  }
}
