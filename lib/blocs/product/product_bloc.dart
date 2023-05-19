import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/model.dart';
import 'package:ecommerce_app/repositories/product/product.repository.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository}) 
  :_productRepository = productRepository, 
  super(ProductLoading()){
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProducts>(_onUpdateProducts);
  }
  
  void _onLoadProducts(event, Emitter<ProductState> emit){
    _productSubscription?.cancel();
    _productSubscription = _productRepository.getAllProducts().listen((products) => add(UpdateProducts(products)));
  }

  void _onUpdateProducts(event, Emitter<ProductState> emit){
    emit(ProductLoaded(products: event.products));
  }
}
