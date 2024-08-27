import 'dart:async';

import 'package:enk_asses/features/glocery/data_layer/model/grocery_model.dart';
import 'package:enk_asses/features/glocery/domain/usecase/get_groceries_usecase.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_event.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  GetGroceriesUsecase getGroceriesUsecase;
  FoodBloc({required this.getGroceriesUsecase}) : super(FoodState()) {
    on<FetchFoodEvent>(_fetchFood);
    on<AddToCartEvent>(_addToCart);
    on<RemoveFromCartEvent>(_removeFromCart);
    on<AddOptionsEvent>(_addOptions);
    on<RemoveOptionsEvent>(_removeOptions);
    on<RemoveAllFromCartEvent>(_removeAllFromCart);
    on<PlaceOrderEvent>(_placeOrder);
  }

  FutureOr<void> _fetchFood(
      FetchFoodEvent event, Emitter<FoodState> emit) async {
    emit(state.copyWith(status: FoodStaus.loading));
    final result = await getGroceriesUsecase.execute();
    result.fold((failure) {
      emit(state.copyWith(status: FoodStaus.error));
    }, (groceries) {
      final groceryList =
          groceries.map((e) => GroceryModel.fromEntity(e)).toList();
      emit(state.copyWith(status: FoodStaus.loaded, groceries: groceryList));
    });
  }

  FutureOr<void> _addToCart(AddToCartEvent event, Emitter<FoodState> emit) {
    final updatedBasket = Map<GroceryModel, List<dynamic>>.from(state.basket);
    final currentTotal = state.totalPrice;
    final currentDiscount = state.totalDiscount;
   
    if (updatedBasket.containsKey(event.groceryModel)) {
      // Copy the current list and update the quantity
      final currentList =
          List<dynamic>.from(updatedBasket[event.groceryModel]!);
      currentList[0] = (currentList[0] as int) + 1;

      // Update the basket with the new list
      updatedBasket[event.groceryModel] = currentList;
    } else {
      // Initialize with quantity and empty list of options
      updatedBasket[event.groceryModel] = [1, ...[]];
    }
    final newTotal = currentTotal + event.groceryModel.price;
    final newDiscount = currentDiscount + event.groceryModel.discount;

    emit(state.copyWith(
        basket: updatedBasket,
        totalPrice: newTotal,
        totalDiscount: newDiscount));
  }

  FutureOr<void> _removeFromCart(
      RemoveFromCartEvent event, Emitter<FoodState> emit) {
    final updatedBasket = Map<GroceryModel, List<dynamic>>.from(state.basket);
    final currentTotal = state.totalPrice;
    final currentDiscount = state.totalDiscount;

    if (updatedBasket.containsKey(event.groceryModel)) {
      final currentList = updatedBasket[event.groceryModel]!;

      // Access and update the quantity
      final currentQuantity = currentList[0] as int;
      final newQuantity = currentQuantity - 1;

      if (newQuantity <= 0) {
        // Remove the item from the basket if the quantity is zero or less
        updatedBasket.remove(event.groceryModel);
      } else {
        // Update the quantity in the basket
        updatedBasket[event.groceryModel] = [
          newQuantity,
          ...currentList.skip(1)
        ];
      }
      final newTotal = currentTotal - event.groceryModel.price;
      final newDiscount = currentDiscount - event.groceryModel.discount;
      emit(state.copyWith(
          basket: updatedBasket,
          totalPrice: newTotal,
          totalDiscount: newDiscount));
    }

    // Emit the new state with the updated basket
  }

  FutureOr<void> _addOptions(AddOptionsEvent event, Emitter<FoodState> emit) {
    final currentTotal = state.totalPrice;

    final updatedBasket = Map<GroceryModel, List<dynamic>>.from(state.basket);
    if (updatedBasket.containsKey(event.groceryModel)) {
      final currentList = updatedBasket[event.groceryModel]!;
      currentList.add(event.optionsModel);
      updatedBasket[event.groceryModel] = currentList;
      final newTotal = currentTotal + event.optionsModel.price;

      emit(state.copyWith(basket: updatedBasket, totalPrice: newTotal));
    } else {


      // updatedBasket[event.groceryModel] = [
      //   1,
      //   [event.optionsModel]
      // ];
      // final newTotal = currentTotal + event.optionsModel.price;
      // final newDiscount = state.totalDiscount + event.groceryModel.discount;
      // emit(state.copyWith(basket: updatedBasket, totalPrice: newTotal, totalDiscount: newDiscount));
    }
  }

  FutureOr<void> _removeOptions(
      RemoveOptionsEvent event, Emitter<FoodState> emit) {
    final currentTotal = state.totalPrice;
    final updatedBasket = Map<GroceryModel, List<dynamic>>.from(state.basket);
    if (updatedBasket.containsKey(event.groceryModel)) {
      final currentList = updatedBasket[event.groceryModel]!;
      currentList.remove(event.optionsModel);
      updatedBasket[event.groceryModel] = currentList;
      final newTotal = currentTotal - event.optionsModel.price;
      emit(state.copyWith(basket: updatedBasket, totalPrice: newTotal));
    }
    emit(state.copyWith(basket: updatedBasket));
  }

  FutureOr<void> _removeAllFromCart(
      RemoveAllFromCartEvent event, Emitter<FoodState> emit) {
    final currentTotal = state.totalPrice;
    final updatedBasket = Map<GroceryModel, List<dynamic>>.from(state.basket);
    List currList = updatedBasket[event.groceryModel]!;
    double newTotal = currentTotal - event.groceryModel.price * currList[0];
    double newDiscount =
        state.totalDiscount - event.groceryModel.discount * currList[0];
    for (var option in currList.skip(1)) {
      newTotal -= option.price;
    }
    updatedBasket.remove(event.groceryModel);
    emit(state.copyWith(
        basket: updatedBasket,
        totalPrice: newTotal,
        totalDiscount: newDiscount));
  }

  FutureOr<void> _placeOrder(PlaceOrderEvent event, Emitter<FoodState> emit) {
    emit(state.copyWith(basket: {}, totalPrice: 0, totalDiscount: 0));
  }
}
