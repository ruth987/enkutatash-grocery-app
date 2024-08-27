import 'package:enk_asses/features/glocery/data_layer/model/grocery_model.dart';
import 'package:enk_asses/features/glocery/data_layer/model/options_model.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_bloc.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_event.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionsCard extends StatelessWidget {
  final GroceryModel groceryModel;
  final OptionsModel optionsModel;

  const OptionsCard({
    super.key,
    required this.optionsModel,
    required this.groceryModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        final options = state.basket[groceryModel] ?? [];
        final isSelected = options.contains(optionsModel);

        return Row(
          children: [
            Text(optionsModel.name,
                style: TextStyle(
                  fontSize: 16,
                )),
            Spacer(),
            Text("+ €${optionsModel.price.toString()}",
                style: TextStyle(fontSize: 16)),
            Checkbox(
              value: isSelected,
              onChanged: (bool? newValue) {
                if (newValue == true) {
                  context.read<FoodBloc>().add(AddOptionsEvent(
                        groceryModel: groceryModel,
                        optionsModel: optionsModel,
                      ));
                } else {
                  context.read<FoodBloc>().add(RemoveOptionsEvent(
                        groceryModel: groceryModel,
                        optionsModel: optionsModel,
                      ));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
