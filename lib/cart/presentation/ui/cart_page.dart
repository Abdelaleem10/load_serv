import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadserv_task/cart/presentation/manager/cart_cubit.dart';
import 'package:loadserv_task/cart/presentation/manager/cart_state.dart';
import 'package:loadserv_task/cart/presentation/ui/card_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return ListView(
            children: [
              CardItem(
                  image: null,
                  name: null,
                  price: null,
                  valueTrigger: (numbers) {

                  },)
            ],
          );
        },
      ),
    );
  }
}
