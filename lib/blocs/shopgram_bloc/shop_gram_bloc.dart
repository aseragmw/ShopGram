import 'package:bloc/bloc.dart';
import 'package:db_shop/services/firestore_database.dart';
import 'package:meta/meta.dart';
import '../../models/product_model.dart';
part 'shop_gram_event.dart';
part 'shop_gram_state.dart';

class ShopGramBloc extends Bloc<ShopGramEvent, ShopGramState> {
  ShopGramBloc() : super(ShopGramInitial()) {
    on<GetCartProductsEvent>((event, emit) async {
      print('getting inside bloc;;;');
      emit(LoadingState());

      final cartProductsStream =
          FirestoreDatabase.getInstance().getCartProductsStream();
      final tst = await cartProductsStream.toList();

      print(tst.length);
      for (int i = 0; i < tst.length; i++) {
        print(tst.first.values.elementAt(i));
      }
      emit(GotCartProductsState(cartProductsStream));
    });

    on<DeleteCartProductEvent>((event, emit) {
      FirestoreDatabase.getInstance()
          .deleteProductFromCart(event.cartId, event.product);
    });

    on<IncrementCartProductCountEvent>((event, emit) async {
      await FirestoreDatabase.getInstance()
          .incrementProductInCart(event.cartId, event.product);
    });

    on<DecrementCartProductCountEvent>((event, emit) async {
      await FirestoreDatabase.getInstance()
          .decrementProductInCart(event.cartId, event.product);
    });
  }
}
