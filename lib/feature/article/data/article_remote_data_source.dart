import 'package:novanews/feature/article/data/model/article_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ArticleRemoteDataSource {
  final SupabaseClient _supabaseClient;

  const ArticleRemoteDataSource(this._supabaseClient);

  Future<List<ArticleModel>> getArticles() async {
    final response = await _supabaseClient
        .from('articles')
        .select()
        .order('created_at', ascending: false);

    final List<dynamic> data = response as List<dynamic>;
    return data.map((json) => ArticleModel.fromJson(json)).toList();
  }
}

