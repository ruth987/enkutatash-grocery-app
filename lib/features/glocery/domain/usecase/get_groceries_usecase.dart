import 'package:dartz/dartz.dart';
import 'package:enk_asses/core/failure/failure.dart';
import 'package:enk_asses/features/glocery/domain/entity/grocery.dart';
import 'package:enk_asses/features/glocery/domain/repo/grocery_repo.dart';

class GetGroceriesUsecase{
  final GroceryRepo _groceryRepo;

  GetGroceriesUsecase(this._groceryRepo);

  Future<Either<Failure,List<Grocery>>> execute() async {
    return await _groceryRepo.getGroceries();
  }
} 