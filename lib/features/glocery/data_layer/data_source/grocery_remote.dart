import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:enk_asses/core/constant/urs.dart';
import 'package:enk_asses/core/failure/failure.dart';
import 'package:enk_asses/features/glocery/data_layer/model/grocery_model.dart';

class GroceryRemoteDataSource {
  final Dio dio;

  GroceryRemoteDataSource({required this.dio});

  Future<Either<Failure, List<GroceryModel>>> fetchAllGroceries() async {
    try {
      final response = await dio.get(Urls.baseUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final List<dynamic> groceryList = responseData['data'];

        final List<GroceryModel> groceries = groceryList.map((element) {
          var x = GroceryModel.fromJson(element);
          
          return x;
        }).toList();

        return Right(groceries);
      } else {
        return Left(Failure(message: 'Failed to load groceries'));
      }
    } catch (e) {
      throw Exception('Error fetching groceries: $e');
    }
  }
}
