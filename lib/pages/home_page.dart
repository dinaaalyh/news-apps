import 'package:flutter/material.dart';
import 'package:news_apps/providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:news_apps/widgets/category_chip.dart';
import 'package:news_apps/widgets/news_card.dart';
import 'package:news_apps/widgets/search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<NewsProvider>().fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = context.watch<NewsProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Discover',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'News from all around the world',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const SearchField(),
            const SizedBox(height: 16),
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryChip(text: 'All', isActive: true),
                  CategoryChip(text: 'Politics'),
                  CategoryChip(text: 'Sport'),
                  CategoryChip(text: 'Education'),
                  CategoryChip(text: 'Games'),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: Builder(
                builder: (_) {
                  if (newsProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (newsProvider.errorMessage.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(newsProvider.errorMessage),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              newsProvider.fetchNews();
                            },
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (newsProvider.articles.isEmpty) {
                    return const Center(
                      child: Text('No news available'),
                    );
                  }
                  return ListView.builder(
                    itemCount: newsProvider.articles.length,
                    itemBuilder: (context, index) {
                      final article = newsProvider.articles[index];

                      return NewsCard(
                        image: article.imageUrl.isNotEmpty ? article.imageUrl : 'https://picsum.photos/200',
                        category: 'Business',
                        title: article.title,
                        author: article.author ?? 'Unknown',
                        date: article.publishedAt ?? '',
                        description: article.description ?? '',
                      );
                    },
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
