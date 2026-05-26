import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novanews/core/theme/app_colors.dart';
import 'package:novanews/core/theme/app_styles.dart';
import 'package:novanews/feature/home/data/model/article_model.dart';
import 'package:novanews/feature/home/presentation/cubit/home_cubit.dart';
import 'package:novanews/feature/home/presentation/cubit/home_state.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchArticles(),
      child: Scaffold(
        backgroundColor: AppColors.neutralBg,
        appBar: const HomeAppBar(),
        body: const HomeBodyContent(),
      ),
    );
  }
}

// كلاس مستقل للـ AppBar العلوي مطابق للصورة المعروضة
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0.5,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AppColors.neutralDarkest),
        onPressed: () {},
      ),
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'N',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'NovaNews',
            style: AppStyles.headlineMedium.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.neutralDarkest),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// كلاس إدارة حالات الـ Cubit وعرض المحتوى الأساسي
class HomeBodyContent extends StatelessWidget {
  const HomeBodyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (  context, state) {
        final state = context.watch<HomeCubit>().state;

        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state is HomeError) {
          return Center(
            child: Text(state.message, style: AppStyles.bodyLarge),
          );
        }

        if (state is HomeSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: state.articles.length + 1, // +1 لإدراج النص الترحيبي في البداية
            itemBuilder: (context, index) {
              if (index == 0) {
                return const HomeHeaderIntroduction();
              }
              final article = state.articles[index - 1];
              return NewsArticleCard(article: article);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

// كلاس مستقل للنص الترحيبي العلوي المتناسق (The Morning Brief)
class HomeHeaderIntroduction extends StatelessWidget {
  const HomeHeaderIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Text(
            'The Morning Brief',
            style: AppStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.neutralDarkest,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Curated insights for the modern professional. Stay ahead of the curve.',
            textAlign: TextAlign.center,
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.neutralGrey,
            ),
          ),
        ],
      ),
    );
  }
}

// كلاس مستقل لعرض كارت المقال بدقة متطابقة وممتازة للتصميم الثالث المرفق
class NewsArticleCard extends StatelessWidget {
  final ArticleModel article;
  const NewsArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutralDarkest.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عرض الصورة مع الـ Category tag
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.network(
                  article.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: AppColors.secondaryLightest,
                      child: const Icon(Icons.image, size: 50, color: AppColors.secondary),
                    );
                  },
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    article.category,
                    style: AppStyles.labelMedium.copyWith(
                      color: AppColors.neutralDarkest,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // تفاصيل المقال السفلية داخل الكارت
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.readTime.toUpperCase(),
                  style: AppStyles.labelMedium.copyWith(
                    color: AppColors.neutralGrey,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.title,
                  style: AppStyles.headlineMedium.copyWith(
                    fontSize: 20,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.subtitle,
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.neutralGrey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}