import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem("T-shirts with multiple colors for men",
        "Size: medium, Color: blue", "Seller: Artel Market", 2, 78.99),
    CartItem("Solid Backpack blue jeans large size",
        "Size: medium, Color: blue", "Seller: Artel Market", 1, 78.99),
    CartItem("Water boiler black for kitchen, 1200 Watt",
        "Size: medium, Color: blue", "Seller: Artel Market", 2, 78.99),
  ];

  List<SavedItem> savedItems = [
    SavedItem(
        "Regular Fit Resort Shirt", 57.70, "https://via.placeholder.com/50"),
    SavedItem(
        "Regular Fit Resort Shirt", 57.70, "https://via.placeholder.com/50"),
    SavedItem(
        "Regular Fit Resort Shirt", 57.70, "https://via.placeholder.com/50"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Shopping cart'),
            floating: true,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < cartItems.length) {
                  return _buildCartItem(cartItems[index]);
                } else if (index == cartItems.length) {
                  return _buildOrderSummary();
                } else if (index == cartItems.length + 1) {
                  return _buildCheckoutButton();
                } else if (index == cartItems.length + 2) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Saved for later',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  int savedItemIndex = index - (cartItems.length + 3);
                  if (savedItemIndex < savedItems.length) {
                    return _buildSavedItem(savedItems[savedItemIndex]);
                  }
                }
                return null;
              },
              childCount: cartItems.length + savedItems.length + 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network('https://via.placeholder.com/80',
                width: 80, height: 80),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(item.details,
                      style: const TextStyle(color: Colors.grey)),
                  Text(item.seller, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildQuantitySelector(item),
                      const Spacer(),
                      Text('\$${item.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(CartItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.remove), onPressed: () {}),
          Text('${item.quantity}'),
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSummaryRow('Items (3):', '\$32.00'),
          _buildSummaryRow('Shipping:', '\$10.00'),
          _buildSummaryRow('Tax:', '\$7.00'),
          const Divider(),
          _buildSummaryRow('Total:', '\$220.00', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 76, 106, 175),
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () {},
        child: const Text(
          'Checkout (3 items)',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSavedItem(SavedItem item) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image.network(item.imageUrl, width: 60, height: 60),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('\$${item.price.toStringAsFixed(2)}'),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.move_down,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final String name;
  final String details;
  final String seller;
  int quantity;
  final double price;

  CartItem(this.name, this.details, this.seller, this.quantity, this.price);
}

class SavedItem {
  final String name;
  final double price;
  final String imageUrl;

  SavedItem(this.name, this.price, this.imageUrl);
}
