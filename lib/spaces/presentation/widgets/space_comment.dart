import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class SpaceComment extends StatelessWidget {
  final String author;
  final String text;
  final int rating;

  const SpaceComment({
    super.key,
    required this.author,
    required this.text,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        author,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),
                    StarRating(
                        starCount: 5,
                        rating: rating * 1.0,
                        allowHalfRating: false,
                        color: Colors.orangeAccent),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  text,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
