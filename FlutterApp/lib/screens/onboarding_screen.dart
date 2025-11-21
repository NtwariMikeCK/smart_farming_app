// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/theme_toggle_button.dart';
import 'home_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              _buildWelcomePage(theme),
              _buildHowItWorksPage(theme),
              _buildBenefitsPage(theme),
            ],
          ),
          const Positioned(top: 50, right: 16, child: ThemeToggleButton()),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: WormEffect(
                  dotWidth: 12,
                  dotHeight: 12,
                  activeDotColor: theme.colorScheme.primary,
                  dotColor: theme.colorScheme.primary.withOpacity(0.3),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  IconButton(
                    onPressed: _previousPage,
                    icon: const Icon(Icons.arrow_back),
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary.withOpacity(
                        0.1,
                      ),
                      padding: const EdgeInsets.all(12),
                    ),
                  )
                else
                  const SizedBox(width: 48),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(_currentPage == 2 ? 'Start Now' : 'Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomePage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.agriculture, size: 120, color: theme.colorScheme.primary),
          const SizedBox(height: 40),
          Text(
            'Welcome to\nSmart Farming',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Predict crop yields using AI and sensor data to make data-driven farming decisions',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksPage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'How It Works',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          _buildStep(
            theme,
            Icons.sensors,
            'Sensor Data',
            'Collect environmental data from your farm',
          ),
          const SizedBox(height: 24),
          Icon(Icons.arrow_downward, color: theme.colorScheme.primary),
          const SizedBox(height: 24),
          _buildStep(
            theme,
            Icons.psychology,
            'AI Model',
            'Machine learning analyzes patterns',
          ),
          const SizedBox(height: 24),
          Icon(Icons.arrow_downward, color: theme.colorScheme.primary),
          const SizedBox(height: 24),
          _buildStep(
            theme,
            Icons.analytics,
            'Prediction',
            'Get accurate yield forecasts',
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsPage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Key Benefits',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          _buildBenefit(
            theme,
            Icons.trending_up,
            'Improve Productivity',
            'Optimize crop yields based on data',
          ),
          const SizedBox(height: 20),
          _buildBenefit(
            theme,
            Icons.water_drop,
            'Optimize Resources',
            'Smart water and fertilizer usage',
          ),
          const SizedBox(height: 20),
          _buildBenefit(
            theme,
            Icons.eco,
            'Precision Agriculture',
            'Make informed farming decisions',
          ),
          const SizedBox(height: 20),
          _buildBenefit(
            theme,
            Icons.savings,
            'Reduce Costs',
            'Minimize waste and maximize profits',
          ),
        ],
      ),
    );
  }

  Widget _buildStep(ThemeData theme, IconData icon, String title, String desc) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: theme.colorScheme.primary, size: 32),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(desc, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBenefit(
    ThemeData theme,
    IconData icon,
    String title,
    String desc,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(desc, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
