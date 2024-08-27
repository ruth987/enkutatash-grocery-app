import 'package:enk_asses/features/glocery/presentation/bloc/food_bloc.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_event.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_state.dart';
import 'package:enk_asses/features/glocery/presentation/widget/add_to_cart.dart';
import 'package:enk_asses/features/glocery/presentation/widget/basket_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enk_asses/features/glocery/presentation/widget/snack_bar.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double total = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new_rounded),
        title: Text("My Basket"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // ... existing code ...

              Row(
                children: [
                  Text("Order Summary"),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // Add your navigation logic here
                      Navigator.pushNamed(
                          context, '/'); // Assuming '/' is your home page route
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(
                            color: Colors.red), // Optional: adds a red border
                      ),
                    ),
                    child: Text(
                      "Add items",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

// ... existing code ...
              SizedBox(
                height: height * 0.6,
                child: BlocBuilder<FoodBloc, FoodState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.basket.length,
                      itemBuilder: (context, index) {
                        final groceryModel = state.basket.keys.elementAt(index);
                        final options = state.basket[groceryModel] ?? [];
                        return BasketCard(
                          groceryModel: groceryModel,
                          options: options,
                        );
                        // return Text("${groceryModel.title} ${options[0]}");
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                  height: height * 0.2,
                  child: Column(
                    children: [
                      BlocBuilder<FoodBloc, FoodState>(
                        builder: (context, state) {
                          // Get the current quantity of the groceryModel in the basket
                          final totalPrice = state.totalPrice;
                          final totalDiscount = state.totalDiscount;
                          total = totalPrice - totalDiscount;

                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text("Subtotal",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                  Spacer(),
                                  Text(("€${totalPrice.toString()}"),
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Discount",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                  Spacer(),
                                  Text(("€${totalDiscount.toString()}"),
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                children: [
                                  Text("Total",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                  Spacer(),
                                  Text(("€${total.toString()}"),
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                // Get the current quantity of the groceryModel in the basket
                final totalPrice = state.totalPrice;
                final totalDiscount = state.totalDiscount;
                total = totalPrice - totalDiscount;

                return Text(
                  "€${total.toString()}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                );
              },
            ),
            Spacer(),
            AddToCart(
                message: "Place Order",
                width: width * 0.3,
                height: height * 0.07,
                onCallback: () {
                  context.read<FoodBloc>().add(PlaceOrderEvent());
                  SnackBarHelper.showSnackBar(context, "Order placed successfully");
                })
          ],
        ),
      ),
    );
  }
}
