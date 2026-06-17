import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novanews/feature/article/data/article_remote_data_source.dart';
import 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final ArticleRemoteDataSource _remoteDataSource;

  // تمرير الـ Data Source عبر الـ Constructor لفصل المسؤوليات
  ArticleCubit(this._remoteDataSource) : super(ArticleInitial());

  Future<void> fetchArticles() async {
    emit(ArticleLoading());
    try {
      // جلب البيانات من خلال الـ Data Source النظيف المعزول عن الـ UI
      final articles = await _remoteDataSource.getArticles();

      emit(ArticleSuccess(articles));
    } catch (error) {
      emit(ArticleError(error.toString()));
    }
  }
}