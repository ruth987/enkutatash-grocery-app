import 'package:enk_asses/features/glocery/data_layer/model/grocery_model.dart';
import 'package:enk_asses/features/glocery/data_layer/model/options_model.dart';
import 'package:equatable/equatable.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class FetchFoodEvent extends FoodEvent {

}
class AddToCartEvent extends FoodEvent {
  final GroceryModel groceryModel;

  const AddToCartEvent({required this.groceryModel});
}

class RemoveFromCartEvent extends FoodEvent {
  final GroceryModel groceryModel;

  const RemoveFromCartEvent({required this.groceryModel});
}

class AddOptionsEvent extends FoodEvent {
  final GroceryModel groceryModel;
  final OptionsModel optionsModel;

  const AddOptionsEvent({required this.optionsModel, required this.groceryModel});
}


class RemoveOptionsEvent extends FoodEvent {
  final GroceryModel groceryModel;
  final OptionsModel optionsModel;

  const RemoveOptionsEvent({required this.optionsModel, required this.groceryModel});
}

class RemoveAllFromCartEvent extends FoodEvent {
  final GroceryModel groceryModel;

  const RemoveAllFromCartEvent({required this.groceryModel});
}

class PlaceOrderEvent extends FoodEvent {

  const PlaceOrderEvent();
}