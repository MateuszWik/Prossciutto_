import 'package:flutter/material.dart';
import '../main.dart'; // For FoodItems model

class Favorites extends StatelessWidget {
  final List<FoodItems> favoriteItems;
  final void Function(FoodItems) toggleFavorite;
  final bool Function(String) isFavorite;

  const Favorites({
    super.key,
    required this.favoriteItems,
    required this.toggleFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Favorites',
                style: TextStyle(
                  fontFamily: 'LeagueSpartan',
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: favoriteItems.isEmpty
                  ? Center(
                child: Text(
                  "No Favorites",
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = favoriteItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      width: 277,
                      height: 88,
                      decoration: BoxDecoration(
                        color: Color(0xFF0C8C75),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.asset(
                                  item.imagePath,
                                  width: 132,
                                  height: 88,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: '${item.name}\n\n',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: item.price,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: IconButton(
                              icon: Icon(Icons.favorite),
                              color: Colors.white,
                              onPressed: () => toggleFavorite(item),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}