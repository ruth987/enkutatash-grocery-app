import 'package:enk_asses/features/glocery/data_layer/model/grocery_model.dart';
import 'package:enk_asses/features/glocery/data_layer/model/options_model.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_bloc.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_event.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_state.dart';
import 'package:enk_asses/features/glocery/presentation/widget/add_to_cart.dart';
import 'package:enk_asses/features/glocery/presentation/widget/options_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  final GroceryModel groceryModel;
  const DetailPage({super.key, required this.groceryModel});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(groceryModel.imageUrl),
                const Positioned(
                  top: 20,
                  left: 10,
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const Positioned(
                  bottom: 20,
                  right: 10,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                groceryModel.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Text(
                    "€${groceryModel.price.toString()}",
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF989DA3),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                      "€${(groceryModel.price - groceryModel.discount).toString()}",
                      style: const TextStyle(
                          color: Color(0XFFFF6347),
                          fontSize: 22,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  Text(
                    groceryModel.rating.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  const Text(
                    "see all reviews",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0XFF989DA3),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text(
                groceryModel.description,
                style: TextStyle(fontSize: 16, color: Color(0XFF989DA3)),
              ),
            ),
            if (groceryModel.options.length > 1)
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: const Text(
                  "Addtional Options",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            if (groceryModel.options.length > 1)
              Container(
                height: height * 0.3,
                child: ListView.builder(
                    itemCount: groceryModel.options.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: OptionsCard(
                            groceryModel: groceryModel,
                            optionsModel: OptionsModel.fromEntity(
                                groceryModel.options[index])),
                      );
                    }),
              )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                context
                    .read<FoodBloc>()
                    .add(RemoveFromCartEvent(groceryModel: groceryModel));
                // Add logic for decrementing quantity
              },
            ),
            BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                // Get the current quantity of the groceryModel in the basket
                final quantity = state.basket[groceryModel]?.isNotEmpty == true
                    ? state.basket[groceryModel]![0] as int
                    : 0;

                return Text(
                  quantity.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                context
                    .read<FoodBloc>()
                    .add(AddToCartEvent(groceryModel: groceryModel));
                // Add logic for incrementing quantity
              },
            ),
            AddToCart(
                width: width * 0.3,
                height: height * 0.05,
                onCallback: () {
                  context
                      .read<FoodBloc>()
                      .add(AddToCartEvent(groceryModel: groceryModel));
                })
          ],
        ),
      ),
    );
  }
}
