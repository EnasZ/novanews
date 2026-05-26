import 'package:flutter/material.dart';
import 'package:novanews/core/app_images.dart';
import 'package:novanews/core/theme/app_colors.dart';
import 'package:novanews/core/theme/app_styles.dart';


class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralBg,
      body: Stack(
        children: [
          // 1. الصورة الخلفية العلوية للمقال الممتدة للأعلى
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.sizeOf(context).height * 0.45,
            child: Image.asset(
              AppImages.logo, // استبدليها بمسار صورة المقال الحقيقية القادمة من الـ Model
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.primaryMedium,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image, size: 60, color: AppColors.white),
                );
              },
            ),
          ),

          // 2. زر العودة الخلفي العلوي العائم (Back Button) المصمم بدقة
          Positioned(
            top: MediaQuery.paddingOf(context).top + 10,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.neutralDarkest,
                  size: 22,
                ),
              ),
            ),
          ),

          // 3. محتوى تفاصيل المقال داخل حاوية بيضاء منزلقة وقابلة للتمرير
          Positioned.fill(
            top: MediaQuery.sizeOf(context).height * 0.38,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // صف التاريخ ووقت القراءة المنسق بدقة
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                          color: AppColors.neutralGrey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'October 24, 2024',
                          style: AppStyles.labelMedium.copyWith(
                            color: AppColors.neutralGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.circle,
                            size: 4,
                            color: AppColors.neutralGrey,
                          ),
                        ),
                        Text(
                          '6 min read',
                          style: AppStyles.labelMedium.copyWith(
                            color: AppColors.neutralGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // عنوان المقال الرئيسي بخط عريض ومتناسق
                    Text(
                      'The Future of Urban Architecture: How Sustainable Design is Redefining the Modern Skyline',
                      style: AppStyles.headlineLarge.copyWith(
                        color: AppColors.neutralDarkest,
                        fontSize: 26,
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // النص الوصفي الداخلي للمقال
                    Text(
                      'As global populations continue to shift towards urban centers, the demand for high-density living solutions that don\'t sacrifice environmental integrity has reached a critical tipping point. Today\'s architects are no longer just building structures; they are crafting living ecosystems that breathe, recycle, and adapt to their surroundings.',
                      style: AppStyles.bodyLarge.copyWith(
                        color: AppColors.neutralDark,
                        height: 1.6,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // نص إضافي لدعم التمرير والانسيابية
                    Text(
                      'By integrating vertical gardens, advanced solar harvesting, and localized water treatment systems, these modern skyscrapers reduce the collective carbon footprint while establishing a new aesthetic paradigm for twenty-first century cities.',
                      style: AppStyles.bodyLarge.copyWith(
                        color: AppColors.neutralDark,
                        height: 1.6,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}