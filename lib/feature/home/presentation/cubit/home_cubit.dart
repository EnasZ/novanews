import 'package:bloc/bloc.dart';
import 'package:novanews/feature/home/data/model/article_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchArticles() async {
    emit(HomeLoading());
    try {
      // جلب البيانات من جدول البريد أو المقالات في سوبابيز مرتبة حسب الأحدث
      final response = await Supabase.instance.client
          .from('articles')
          .select()
          .order('created_at', ascending: false);

      final List<dynamic> data = response as List<dynamic>;
      final articles = data.map((json) => ArticleModel.fromJson(json)).toList();

      emit(HomeSuccess(articles));
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }
}