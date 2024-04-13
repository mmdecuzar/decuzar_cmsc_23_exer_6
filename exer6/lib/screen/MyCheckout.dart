import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class MyCheckout extends StatelessWidget {
  const MyCheckout({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: checkout(context),
    );
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    return products.isEmpty
        ? const Text('No Items yet!')
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: const Icon(Icons.food_bank),
                      title: Text(products[index].name),
                      trailing: Text('${products[index].price}'));
                },
              )),
            ],
          ));
  }

  Widget checkout(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    return products.isEmpty
        ? const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No items to checkout'),
          ],
        )
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getItems(context),
            const Divider(height: 4, color: Colors.black),
            Text('Total Price: ${context.read<ShoppingCart>().cartTotal}'),
            Flexible(
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                            context.read<ShoppingCart>().removeAll();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Payment Successful'),
                              duration: Duration(seconds: 1, milliseconds: 100),
                            ));
                          },
                          child: const Text("Pay Now!")),
                        ]
                      )
                    )
                  ),
                ],
              );
            }
}
