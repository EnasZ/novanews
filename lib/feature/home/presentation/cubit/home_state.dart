import 'package:novanews/feature/home/data/model/article_model.dart';


abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ArticleModel> articles;
  const HomeSuccess(this.articles);
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}