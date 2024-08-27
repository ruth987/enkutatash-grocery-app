import 'package:enk_asses/features/glocery/data_layer/model/grocery_model.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final GroceryModel groceryModel;
  const FoodCard({super.key, required this.groceryModel});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detail', arguments: groceryModel);
          },
          child: Container(
              width: width * 0.4,
              height: height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Container(
                    height: height * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            groceryModel.imageUrl,
                            width: double.infinity,
                            height: height * 0.12,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            groceryModel.title,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Text(
                                groceryModel.rating.toString(),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              "€${groceryModel.price.toString()}",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Color(0XFF989DA3),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                                "€${(groceryModel.price - groceryModel.discount).toString()}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              )),
        ));
  }
}
