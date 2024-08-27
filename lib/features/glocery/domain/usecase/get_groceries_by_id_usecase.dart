import 'package:dartz/dartz.dart';
import 'package:enk_asses/core/failure/failure.dart';
import 'package:enk_asses/features/glocery/domain/entity/grocery.dart';
import 'package:enk_asses/features/glocery/domain/repo/grocery_repo.dart';

class GetGroceriesByIdUsecase{
  final GroceryRepo _groceryRepo;

  GetGroceriesByIdUsecase(this._groceryRepo);

  Future<Either<Failure,Grocery>> execute(String id) async {
    return await _groceryRepo.getGroceryById(id);
  }
} 