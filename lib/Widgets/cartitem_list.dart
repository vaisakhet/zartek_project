import 'package:flutter/material.dart';
import 'package:zartek_project/Widgets/veg_or_nonveg.dart';
import 'count_button.dart';

class CartItemList extends StatelessWidget {
  const CartItemList(
      {super.key,
      required this.productId,
      required this.title,
      required this.calories,
      required this.price,
      required this.index,
      required this.quantity});

  final String productId;
  final String title;
  final double calories;
  final double price;
  final int index;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GreenCircleContainer(
              index % 2 == 0 ? Colors.green : Colors.red[300]!),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CountButtons(quantity, productId),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'INR $price',
                        style: const TextStyle(fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('INR ${price * quantity}'),
                const SizedBox(
                  height: 10,
                ),
                Text('Calories $calories')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
