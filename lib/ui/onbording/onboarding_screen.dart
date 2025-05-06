import 'package:beyondmarks/route_manager.dart';
import 'package:beyondmarks/ui/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, Routes.studentInputScreen);
    }
  }

  final List<Map<String, dynamic>> onboardingData = [
    {
      'icon': Icons.school,
      'title': 'Welcome to BeyondMarks!',
      'description': '',
    },
    {
      'icon': Icons.analytics,
      'title': '🎓 Student Performance Prediction',
      'description':
          'Goal: Predict whether a student will pass or fail based on exam scores and background features.',
    },
    {
      'icon': Icons.stars,
      'title': 'Learning Beyond Scores: Predicting Student Success Using Socio-Academic Factors',
      'description': 'Reach your goals with BeyondMarks.',
    },
  ];

  Widget buildPage({
    required IconData icon,
    required String title,
    required String description,
    required int pageIndex,
  }) {
    final isLast = pageIndex == onboardingData.length - 1;
    final isActive = pageIndex == currentPage;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isActive ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 500),
        offset: isActive ? Offset.zero : const Offset(0.2, 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 100, color: AppColors.iconColor),
              const SizedBox(height: 30),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (pageIndex > 0)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryText,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(120, 50),
                      ),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text('Previous'),
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.iconColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(120, 50),
                    ),
                    onPressed: () {
                      if (isLast) {
                        _completeOnboarding(context);
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(isLast ? 'Get Started' : 'Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: currentPage == index ? 16 : 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: currentPage == index
            ? AppColors.iconColor
            : AppColors.secondaryText.withValues(alpha: 0.3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) => buildPage(
              icon: onboardingData[index]['icon'] as IconData,
              title: onboardingData[index]['title'] as String,
              description: onboardingData[index]['description'] as String,
              pageIndex: index,
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingData.length, buildDot),
            ),
          ),
          if (currentPage < onboardingData.length - 1)
            Positioned(
              top: 40,
              right: 20,
              child: TextButton(
                onPressed: () => _completeOnboarding(context),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
