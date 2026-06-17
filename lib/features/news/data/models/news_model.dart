/// Model class representing a News Article in the NovaNews app.
class NewsModel {
  final String id;
  final String title;
  final String content;
  final String author;
  final String imageUrl;
  final String category;
  final DateTime publishedAt;

  NewsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.imageUrl,
    required this.category,
    required this.publishedAt,
  });

  /// Mock data for demonstration purposes.
  static List<NewsModel> get mockNews => [
    NewsModel(
      id: '1',
      title: 'Global Markets Rally as Inflation Cools Down',
      content: 'Investors across the globe are showing optimism as recent data suggests inflation is finally stabilizing...',
      author: 'John Doe',
      imageUrl: 'https://picsum.photos/seed/news1/600/400',
      category: 'Finance',
      publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NewsModel(
      id: '2',
      title: 'New Tech Breakthrough in Renewable Energy',
      content: 'Scientists have discovered a new material that could double the efficiency of solar panels...',
      author: 'Jane Smith',
      imageUrl: 'https://picsum.photos/seed/news2/600/400',
      category: 'Technology',
      publishedAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];
}
