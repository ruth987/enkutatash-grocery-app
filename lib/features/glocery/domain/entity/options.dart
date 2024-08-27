import 'package:equatable/equatable.dart';

class Options extends Equatable{
  final String id;
  final String name;
  final double price;

  Options({
    required this.id,
    required this.name,
    required this.price,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, price];
}