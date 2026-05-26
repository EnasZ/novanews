class ArticleModel {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String readTime;
  final String imageUrl;

  const ArticleModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.readTime,
    required this.imageUrl,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      category: json['category'] ?? '',
      readTime: json['read_time'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}