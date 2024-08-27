import 'package:enk_asses/features/glocery/presentation/bloc/food_bloc.dart';
import 'package:enk_asses/features/glocery/presentation/bloc/food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/searchField.dart';
import '../widget/food_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/food.png'),
            SizedBox(
              width: 10,
            ),
            Text("Burger")
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/basket');
              },
              icon: Icon(Icons.add_shopping_cart)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Searchfield(),
          SizedBox(
            height: 10,
          ),
          Expanded(child: BlocBuilder<FoodBloc, FoodState>(
            builder: (context, state) {
              if (state.status == FoodStaus.loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.status == FoodStaus.error) {
                return Center(child: Text('Error loading groceries'));
              } else if (state.status == FoodStaus.loaded) {
                return GridView.builder(
                    itemCount: state.groceries.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return FoodCard(groceryModel: state.groceries[index]);
                    });
              } else {
                return Container(); // Handle initial state
              }
            },
          ))
        ],
      ),
    );
  }
}
