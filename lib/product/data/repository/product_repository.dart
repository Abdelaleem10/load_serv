import 'dart:convert';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loadserv_task/common/constant/constant.dart';
import 'package:loadserv_task/common/domain/exceptions/exceptions.dart';
import 'package:loadserv_task/common/domain/exceptions/status_codes.dart';
import 'package:loadserv_task/product/data/extensions/category_extensions.dart';
import 'package:loadserv_task/product/data/extensions/product_details_extension.dart';
import 'package:loadserv_task/product/data/model/api_get_category_details_model.dart';
import 'package:loadserv_task/product/data/model/api_product_details_model.dart';
import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';
import 'package:loadserv_task/product/domain/entity/product_entity.dart';
import 'package:loadserv_task/product/domain/repository/product_repository.dart';
import 'package:http/http.dart' as http;

class CategoryRepositoryImp implements CategoryRepository {
  @override
  Future<CategoryEntity> getCategory() async {
    try {
      final result = await http.get(Uri.parse(Constant.getCategory));
      if (result.statusCode != 200) {
        throw const ServerException();
      } else {
        var data = jsonDecode(result.body);
        print('data is ${data.toString()}');
        final request = ApiWelcomeModel.fromJson(data).categoryModel;
        return request?.map() ?? CategoryEntity.initial();
      }
    } catch (e) {
      throw ApiRequestException(StatusCodes.unknown, "sorry something error");
    }
  }

  @override
  Future<ProductDetailsEntity> getProductDetails(String productId)async {
    try {
      final result = await http.get(Uri.parse(Constant.productDetails+productId));
      if (result.statusCode != 200) {
        throw const ServerException();
      } else {
        var data = jsonDecode(result.body);
        print('data is ${data.toString()}');
        final request = ApiProductDetailsResponse.fromJson(data).data;
        return request?.map() ?? ProductDetailsEntity.initial();
      }
    } catch (e) {
      throw ApiRequestException(StatusCodes.unknown, "sorry something error");
    }
  }

}
