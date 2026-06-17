import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

/// Onboarding Screen to introduce users to NovaNews features.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Trusted Stories",
      "subtitle": "Get the latest news from verified sources across the globe.",
      "image": "https://picsum.photos/seed/ob1/400/400",
    },
    {
      "title": "Personalized Feed",
      "subtitle": "Customize your news feed based on your interests and preferences.",
      "image": "https://picsum.photos/seed/ob2/400/400",
    },
    {
      "title": "Breaking News",
      "subtitle": "Real-time notifications for the stories that matter most.",
      "image": "https://picsum.photos/seed/ob3/400/400",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => context.go('/login'),
                child: const Text("Skip", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) => _buildPageItem(index),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Indicator Dots
                  Row(
                    children: List.generate(
                      _onboardingData.length,
                      (index) => _buildDot(index),
                    ),
                  ),
                  // Next/Get Started Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(140, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      if (_currentPage == _onboardingData.length - 1) {
                        context.go('/login');
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: Text(_currentPage == _onboardingData.length - 1 ? "Get Started" : "Next"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds each individual onboarding slide.
  Widget _buildPageItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(_onboardingData[index]["image"]!, height: 300),
          const Gap(40),
          Text(
            _onboardingData[index]["title"]!,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Gap(16),
          Text(
            _onboardingData[index]["subtitle"]!,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Helper to build indicator dots.
  Widget _buildDot(int index) {
    return Container(
      height: 8,
      width: _currentPage == index ? 24 : 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.primary : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
