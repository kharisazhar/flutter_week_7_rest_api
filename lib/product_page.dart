import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_week_7_rest_api/core/network/api_endpoint.dart';
import 'package:flutter_week_7_rest_api/core/network/network_services.dart';
import 'package:flutter_week_7_rest_api/model/product/Product_model.dart';
import 'package:flutter_week_7_rest_api/model/product/Product_response.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductModel? productData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    productData = await getProduct();
    addProduct(productName: 'Macbook pro M2');
    setState(() {});
  }

  Future<ProductModel> getProduct() async {
    var response = await NetworkServices().get(endpoint: ApiEndpoint.products);

    /// Basic Decode
    // debugPrint("RESPONSE ${jsonDecode(response.body)}");

    /// Deserialization
    ProductModel productData = ProductModel.fromJson(jsonDecode(response.body));
    productData.products?.forEach((element) {
      debugPrint("RESPONSE PRODUCT : ${element.title}");
    });

    return productData;
  }

  void addProduct({required String productName}) async {
    var url = Uri.https('dummyjson.com', '/products/add');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},

      /// Serialization
      body: jsonEncode({'title': productName}),
    );

    /// Basic Decode
    debugPrint("RESPONSE ADD PRODUCT :  ${jsonDecode(response.body)}");

    /// Deserialization
    var result = ProductResponse.fromJson(jsonDecode(response.body));
    debugPrint("RESPONSE ADD PRODUCT : ${result.title}");
    debugPrint("RESPONSE ADD PRODUCT : ${result.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter HTTP DEMO"),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: productData?.products?.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${(productData?.products ?? [])[index].title}'),
              subtitle:
                  Text(' \$ ${(productData?.products ?? [])[index].price} '),
            );
          }),
    );
  }
}
