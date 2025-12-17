import 'package:flutter/material.dart';
import '../pages/detail_page.dart';

class NewsCard extends StatelessWidget {
  final String image;
  final String category;
  final String title;
  final String author;
  final String date;

  const NewsCard({
    super.key,
    required this.image,
    required this.category,
    required this.title,
    required this.author,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPage(
              image: image,
              title: title,
              category: category,
              author: author,
              date: date,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 34),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$author · $date',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
