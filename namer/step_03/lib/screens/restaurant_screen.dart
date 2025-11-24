import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: Column(
        children: [
          Image.network(restaurant.imageUrl,
              width: double.infinity, height: 200, fit: BoxFit.cover),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  restaurant.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text("${restaurant.cuisine} • ⭐ ${restaurant.rating}"),
                Text("${restaurant.distanceKm} km • ${restaurant.etaMinutes} min away"),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text("Start Order"),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Ordering flow coming next!")),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
