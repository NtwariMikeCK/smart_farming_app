// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/theme_toggle_button.dart';
import 'predict_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Farming'),
        actions: const [ThemeToggleButton(), SizedBox(width: 8)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIntroSection(theme),
            const SizedBox(height: 30),
            _buildMissionSection(theme),
            const SizedBox(height: 30),
            _buildFeaturesSection(theme),
            const SizedBox(height: 30),
            _buildExampleSection(theme),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PredictScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.analytics),
                label: const Text('Predict Yield Now'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.agriculture,
                  color: theme.colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Crop Yield Prediction System',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Use smart farming sensor data and machine learning to predict crop yields with high accuracy. Make data-driven decisions to optimize your farm productivity.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mission',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Transform raw environmental measurements into accurate yield forecasts, enabling farmers to optimize inputs like water, fertilizer, and pesticides while supporting precision agriculture.',
              style: theme.textTheme.bodyMedium,
            ),
            const Divider(height: 30),
            Text(
              'Problem We Solve',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Farmers collect extensive environmental data but lack systems to translate these measurements into actionable yield predictions. Our ML-powered solution bridges this gap.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Input Parameters',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildFeatureItem(theme, 'Region', 'Geographic location of the farm'),
        _buildFeatureItem(
          theme,
          'Crop Type',
          'Type of crop planted (Wheat, Rice, etc.)',
        ),
        _buildFeatureItem(
          theme,
          'Soil Moisture',
          'Percentage of soil moisture content',
        ),
        _buildFeatureItem(theme, 'Soil pH', 'Soil acidity/alkalinity level'),
        _buildFeatureItem(
          theme,
          'Temperature',
          'Average temperature during growth cycle',
        ),
        _buildFeatureItem(theme, 'Rainfall', 'Total rainfall received (mm)'),
        _buildFeatureItem(
          theme,
          'Humidity',
          'Average environmental humidity (%)',
        ),
        _buildFeatureItem(theme, 'Sunlight Hours', 'Daily sunlight exposure'),
        _buildFeatureItem(theme, 'Irrigation Type', 'Watering method used'),
        _buildFeatureItem(
          theme,
          'Fertilizer Type',
          'Category of fertilizer applied',
        ),
        _buildFeatureItem(
          theme,
          'Pesticide Usage',
          'Amount of pesticide applied (ml)',
        ),
        _buildFeatureItem(
          theme,
          'Total Days',
          'Duration from sowing to harvest',
        ),
        _buildFeatureItem(
          theme,
          'Crop Disease Status',
          'Disease severity level',
        ),
      ],
    );
  }

  Widget _buildFeatureItem(ThemeData theme, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
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
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleSection(ThemeData theme) {
    return Card(
      color: theme.colorScheme.primary.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Example Prediction',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildExampleRow('Region:', 'North India'),
            _buildExampleRow('Crop:', 'Wheat'),
            _buildExampleRow('Soil Moisture:', '38.6%'),
            _buildExampleRow('Soil pH:', '6.5'),
            _buildExampleRow('Temperature:', '22°C'),
            _buildExampleRow('Rainfall:', '150 mm'),
            _buildExampleRow('Total Days:', '110'),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Predicted Yield:',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Text(
                  '4600 kg/hectare',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }
}
