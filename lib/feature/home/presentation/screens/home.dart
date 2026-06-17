import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novanews/core/theme/app_colors.dart';
import 'package:novanews/feature/article/data/article_remote_data_source.dart';
import 'package:novanews/feature/article/presentation/cubit/article_cubit.dart';
import 'package:novanews/feature/article/presentation/screens/articles_list_screen.dart';
import 'package:novanews/feature/shared/widgets/app_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleCubit(ArticleRemoteDataSource(Supabase.instance.client),)..fetchArticles(),
      child: const Scaffold(
        backgroundColor: AppColors.neutralBg,
        appBar: Appbar(),
        body: ArticleListScreen(), 
      ),
    );
  }
}