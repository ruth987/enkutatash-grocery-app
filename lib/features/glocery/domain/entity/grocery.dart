import 'package:enk_asses/features/glocery/domain/entity/options.dart';
import 'package:equatable/equatable.dart';

class Grocery extends Equatable{
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final List<Options> options;
  final double discount;

  Grocery({
     this.id="",
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    this.options=const [],
    this.discount = 0,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, title, description, imageUrl, price, rating, options, discount];
}