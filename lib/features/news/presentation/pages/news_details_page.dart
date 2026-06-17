import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/news_model.dart';
import '../../../../core/theme/app_theme.dart';

/// Detailed View of a specific News Article.
class NewsDetailsPage extends StatelessWidget {
  final NewsModel news;
  const NewsDetailsPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsible Header with Article Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(news.imageUrl, fit: BoxFit.cover),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.5),
              child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => context.pop()),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Metadata: Category and Date
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Text(news.category, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                      ),
                      const Spacer(),
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const Gap(4),
                      Text("June 16, 2026", style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Gap(24),
                  // Article Title
                  Text(news.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, height: 1.3)),
                  const Gap(16),
                  // Author Info
                  Row(
                    children: [
                      const CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=author')),
                      const Gap(12),
                      Text("By ${news.author}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Gap(24),
                  const Divider(),
                  const Gap(24),
                  // Article Content
                  Text(
                    news.content * 10, // Simulating long content
                    style: TextStyle(fontSize: 16, height: 1.8, color: Colors.grey.shade800),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
