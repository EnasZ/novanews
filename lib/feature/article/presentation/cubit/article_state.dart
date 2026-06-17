import 'package:novanews/feature/article/data/model/article_model.dart';


abstract class ArticleState {
  const ArticleState();
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleSuccess extends ArticleState {
  final List<ArticleModel> articles;
  const ArticleSuccess(this.articles);
}

class ArticleError extends ArticleState {
  final String message;
  const ArticleError(this.message);
}