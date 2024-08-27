import 'package:dartz/dartz.dart';
import 'package:enk_asses/core/failure/failure.dart';
import 'package:enk_asses/core/network/network.dart';
import 'package:enk_asses/features/glocery/data_layer/data_source/grocery_remote.dart';
import 'package:enk_asses/features/glocery/data_layer/model/grocery_model.dart';
import 'package:enk_asses/features/glocery/domain/repo/grocery_repo.dart';

class GroceryRepoImp extends GroceryRepo {
  final GroceryRemoteDataSource groceryRemoteDataSource;
  final NetworkInfo networkInfo;
  GroceryRepoImp(
      {required this.groceryRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<GroceryModel>>> getGroceries() async {
    try {
      if (!await networkInfo.isConnected)
        return Left(Failure(message: 'No internet connection'));
      var result = await groceryRemoteDataSource.fetchAllGroceries();
      return result.fold((l) => Left(l), (r) => Right(r));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GroceryModel>> getGroceryById(String id) {
    // TODO: implement getGroceryById
    throw UnimplementedError();
  }
}
