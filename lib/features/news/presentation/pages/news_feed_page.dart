import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/news_model.dart';
import '../../../../core/theme/app_theme.dart';

/// Main Feed Screen displaying a list of news articles.
class NewsFeedPage extends StatelessWidget {
  const NewsFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final newsList = NewsModel.mockNews;

    return Scaffold(
      appBar: AppBar(
        title: const Text("NovaNews Feed"),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () => context.push('/profile')),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: newsList.length,
        itemBuilder: (context, index) => _NewsCard(news: newsList[index]),
      ),
    );
  }
}

/// Custom Widget for News Item Card.
class _NewsCard extends StatelessWidget {
  final NewsModel news;
  const _NewsCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/news-details', extra: news),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Image with Category Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(news.imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                    child: Text(news.category, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Gap(8),
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                      const Gap(4),
                      Text(news.author, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      const Spacer(),
                      const Icon(Icons.access_time, size: 14, color: Colors.grey),
                      const Gap(4),
                      Text("2h ago", style: const TextStyle(color: Colors.grey, fontSize: 12)),
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
