import 'package:enk_asses/features/glocery/domain/entity/options.dart';

class OptionsModel extends Options {
  OptionsModel({
    required String id,
    required String name,
    required double price,
  }) : super(
          id: id,
          name: name,
          price: price,
        );

  factory OptionsModel.fromEntity(Options options) {
    return OptionsModel(
      id: options.id,
      name: options.name,
      price: options.price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory OptionsModel.fromJson(Map<String, dynamic> json) {
    try{

      var x = OptionsModel(
        id: json['id'] as String,
        name: json['name'] as String,
        price: (json['price'] is String)
            ? double.parse(json['price'])
            : (json['price'] as num).toDouble(),
      );

      return x;
    } catch (e) {
            rethrow;
    }
  }
}
