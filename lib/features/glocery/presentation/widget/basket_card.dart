import 'package:enk_asses/features/glocery/data_layer/model/grocery_model.dart';
import 'package:enk_asses/features/glocery/data_layer/model/options_model.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_bloc.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_event.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketCard extends StatelessWidget {
  final GroceryModel groceryModel;
  final List<dynamic> options;
  const BasketCard(
      {super.key, required this.groceryModel, required this.options});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print("options ${options.sublist(1)}");
    List<OptionsModel> optionModels = options.sublist(1).map((option) {
      return option as OptionsModel;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width * 0.9,
        // height: height * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        groceryModel.imageUrl,
                        width: width * 0.2,
                        height: height * 0.07,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(groceryModel.title),
                        Row(
                          children: [
                            Text("€${groceryModel.price.toString()}",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Color(0XFF989DA3),
                                )),
                            Text(
                                "€${(groceryModel.price - groceryModel.discount).toString()}"),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                context.read<FoodBloc>().add(
                                    RemoveFromCartEvent(
                                        groceryModel: groceryModel));
                                // Add logic for decrementing quantity
                              },
                            ),
                            BlocBuilder<FoodBloc, FoodState>(
                              builder: (context, state) {
                                // Get the current quantity of the groceryModel in the basket
                                final quantity =
                                    state.basket[groceryModel]?.isNotEmpty ==
                                            true
                                        ? state.basket[groceryModel]![0] as int
                                        : 0;

                                return Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                context.read<FoodBloc>().add(
                                    AddToCartEvent(groceryModel: groceryModel));
                                // Add logic for incrementing quantity
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                if (options.length > 1)
                  Divider(
                    color: Colors.grey,
                  ),
                if (optionModels.length > 1)
                  for (var option in optionModels)
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(option.name),
                          Spacer(),
                          Text("€${option.price.toString()}"),
                        ],
                      ),
                    )
              ],
            ),
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                icon: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                ),
                onPressed: () {
                  // Add your onPressed logic here
                  context
                      .read<FoodBloc>()
                      .add(RemoveAllFromCartEvent(groceryModel: groceryModel));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
