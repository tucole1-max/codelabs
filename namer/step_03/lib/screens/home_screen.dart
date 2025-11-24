import 'package:flutter/material.dart';
import '../data/mock_restaurants.dart';
import '../models/restaurant.dart';
import 'restaurant_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Restaurant> filtered = mockRestaurants;
  String search = "";
  String sort = "nearest";

  void update() {
    setState(() {
      filtered = mockRestaurants
          .where((r) => r.name.toLowerCase().contains(search.toLowerCase()))
          .toList();

      if (sort == "nearest") {
        filtered.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
      } else if (sort == "rating") {
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
      } else if (sort == "fastest") {
        filtered.sort((a, b) => a.etaMinutes.compareTo(b.etaMinutes));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All You Can Eat"),
      ),
      body: Column(
        children: [
          // SEARCH FIELD
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search restaurants...",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                search = value;
                update();
              },
            ),
          ),

          // SORT DROPDOWN
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField(
              value: sort,
              items: [
                DropdownMenuItem(value: "nearest", child: Text("Nearest")),
                DropdownMenuItem(value: "rating", child: Text("Top Rated")),
                DropdownMenuItem(value: "fastest", child: Text("Fastest Delivery")),
              ],
              onChanged: (value) {
                sort = value!;
                update();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Sort by",
              ),
            ),
          ),

          SizedBox(height: 10),

          // RESTAURANT LIST
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, index) {
                final r = filtered[index];

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RestaurantScreen(restaurant: r),
                    ),
                  ),
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.network(r.imageUrl,
                            width: 100, height: 100, fit: BoxFit.cover),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(r.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18)),
                                SizedBox(height: 4),
                                Text("${r.cuisine} • ⭐ ${r.rating}"),
                                Text("${r.distanceKm} km • ETA ${r.etaMinutes} min"),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
