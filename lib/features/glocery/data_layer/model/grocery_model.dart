import 'package:enk_asses/features/glocery/data_layer/model/options_model.dart';
import 'package:enk_asses/features/glocery/domain/entity/grocery.dart';

class GroceryModel extends Grocery {
  GroceryModel({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
    required double price,
    required double rating,
    List<OptionsModel> options = const [],
    double discount = 0,
  }) : super(
          id: id,
          title: title,
          description: description,
          imageUrl: imageUrl,
          price: price,
          rating: rating,
          options: options,
          discount: discount,
        );

  factory GroceryModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> optionList = json['options'];
    final List<OptionsModel> options = optionList.map((element) {
      return OptionsModel.fromJson(element);
    }).toList();

    return GroceryModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      options: options,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'options': options,
      'discount': discount,
    };
  }

  factory GroceryModel.fromEntity(Grocery grocery) {
    return GroceryModel(
      id: grocery.id,
      title: grocery.title,
      description: grocery.description,
      imageUrl: grocery.imageUrl,
      price: grocery.price,
      rating: grocery.rating,
      options: grocery.options
          .map((option) => OptionsModel.fromEntity(option))
          .toList(),
      discount: grocery.discount,
    );
  }
}
