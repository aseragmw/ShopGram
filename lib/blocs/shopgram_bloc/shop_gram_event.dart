part of 'shop_gram_bloc.dart';

@immutable
abstract class ShopGramEvent {}

class GetCartProductsEvent extends ShopGramEvent {
  final String cartId;

  GetCartProductsEvent(this.cartId);
}

class IncrementCartProductCountEvent extends ShopGramEvent {
  final String cartId;
  final Product product;

  IncrementCartProductCountEvent(this.cartId, this.product);
}

class DecrementCartProductCountEvent extends ShopGramEvent {
  final String cartId;
  final Product product;

  DecrementCartProductCountEvent(this.cartId, this.product);
}

class DeleteCartProductEvent extends ShopGramEvent {
  final String cartId;
  final Product product;

  DeleteCartProductEvent(this.cartId, this.product);
}
