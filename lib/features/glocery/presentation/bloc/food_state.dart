import 'package:enk_asses/features/glocery/data_layer/model/grocery_model.dart';
import 'package:equatable/equatable.dart';

enum FoodStaus {
  initial,
  loading,
  loaded,
  error,
}

// ignore: must_be_immutable
class FoodState extends Equatable {
  final FoodStaus status;
  final List<GroceryModel> groceries;
  Map<GroceryModel, List<dynamic>> basket;
  double totalDiscount;
  double totalPrice;

  FoodState(
      {this.status = FoodStaus.initial,
      this.groceries = const [],
      this.basket = const {},
      this.totalPrice = 0,
      this.totalDiscount = 0});

  FoodState copyWith({
    FoodStaus? status,
    List<GroceryModel>? groceries,
    Map<GroceryModel, List<dynamic>>? basket,
    double? totalPrice,
    double? totalDiscount,
  }) {
    return FoodState(
      status: status ?? this.status,
      groceries: groceries ?? this.groceries,
      basket: basket ?? this.basket,
      totalPrice: totalPrice ?? this.totalPrice,
      totalDiscount: totalDiscount ?? this.totalDiscount,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, groceries, basket, totalPrice, totalDiscount];
}
