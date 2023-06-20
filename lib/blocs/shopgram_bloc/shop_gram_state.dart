part of 'shop_gram_bloc.dart';

@immutable
abstract class ShopGramState {}

class ShopGramInitial extends ShopGramState {}

class GotCartProductsState extends ShopGramState {
  final Stream<Map<Product, int>> cartProductsStream;

  GotCartProductsState(this.cartProductsStream);
}

class LoadingState extends ShopGramState {}
