import 'package:dartz/dartz.dart';
import 'package:enk_asses/core/failure/failure.dart';
import 'package:enk_asses/features/glocery/domain/entity/grocery.dart';

abstract class GroceryRepo{
  Future<Either<Failure,List<Grocery>>> getGroceries();
  Future<Either<Failure,Grocery>> getGroceryById(String id);
}