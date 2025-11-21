// ignore_for_file: deprecated_member_use, use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/prediction_inputs.dart';
import '../services/api_service.dart';
import '../widgets/theme_toggle_button.dart';
import '../constants/dropdown_options.dart';

class PredictScreen extends ConsumerStatefulWidget {
  const PredictScreen({super.key});

  @override
  ConsumerState<PredictScreen> createState() => _PredictScreenState();
}

class _PredictScreenState extends ConsumerState<PredictScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _predictionResult;

  // Dropdown selections
  String? _region;
  String? _cropType;
  String? _irrigationType;
  String? _fertilizerType;
  String? _diseaseStatus;

  // Text controllers
  final _soilMoistureController = TextEditingController();
  final _soilPHController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _rainfallController = TextEditingController();
  final _humidityController = TextEditingController();
  final _sunlightController = TextEditingController();
  final _pesticideController = TextEditingController();
  final _totalDaysController = TextEditingController();

  @override
  void dispose() {
    _soilMoistureController.dispose();
    _soilPHController.dispose();
    _temperatureController.dispose();
    _rainfallController.dispose();
    _humidityController.dispose();
    _sunlightController.dispose();
    _pesticideController.dispose();
    _totalDaysController.dispose();
    super.dispose();
  }

  Future<void> _predictYield() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _predictionResult = null;
    });

    try {
      final input = PredictionInput(
        region: _region!,
        crop_type: _cropType!,
        soil_moisture: double.parse(_soilMoistureController.text),
        soil_pH: double.parse(_soilPHController.text),
        temperature_C: double.parse(_temperatureController.text),
        rainfall_mm: double.parse(_rainfallController.text),
        humidity: double.parse(_humidityController.text),
        sunlight_hours: double.parse(_sunlightController.text),
        irrigation_type: _irrigationType!,
        fertilizer_type: _fertilizerType!,
        pesticide_usage_ml: double.parse(_pesticideController.text),
        total_days: int.parse(_totalDaysController.text),
        crop_disease_status: _diseaseStatus!,
      );

      final apiService = ref.read(apiServiceProvider);
      final result = await apiService.predictYield(input);

      setState(() {
        _predictionResult = result.predictedYield.toStringAsFixed(2);
        _isLoading = false;
      });

      _showResultDialog(result.predictedYield, result.note);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showResultDialog(double yield, String note) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            const Text('Prediction Result'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Predicted Yield',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$yield kg/hectare',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              note,
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Predict Yield'),
        actions: const [ThemeToggleButton(), SizedBox(width: 8)],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Enter Farm Details',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Fill in all the fields to get an accurate yield prediction',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),

            // Categorical Inputs
            _buildSectionTitle(theme, 'Location & Crop Information'),
            _buildDropdown('Region', _region, DropdownOptions.regions, (val) {
              setState(() => _region = val);
            }),
            _buildDropdown('Crop Type', _cropType, DropdownOptions.cropTypes, (
              val,
            ) {
              setState(() => _cropType = val);
            }),

            const SizedBox(height: 20),
            _buildSectionTitle(theme, 'Soil Conditions'),
            _buildNumberField(
              'Soil Moisture (%)',
              _soilMoistureController,
              0,
              100,
            ),
            _buildNumberField('Soil pH', _soilPHController, 0, 14),

            const SizedBox(height: 20),
            _buildSectionTitle(theme, 'Environmental Conditions'),
            _buildNumberField(
              'Temperature (°C)',
              _temperatureController,
              -10,
              50,
            ),
            _buildNumberField('Rainfall (mm)', _rainfallController, 0, 1000),
            _buildNumberField('Humidity (%)', _humidityController, 0, 100),
            _buildNumberField('Sunlight Hours', _sunlightController, 0, 24),

            const SizedBox(height: 20),
            _buildSectionTitle(theme, 'Farm Management'),
            _buildDropdown(
              'Irrigation Type',
              _irrigationType,
              DropdownOptions.irrigationTypes,
              (val) {
                setState(() => _irrigationType = val);
              },
            ),
            _buildDropdown(
              'Fertilizer Type',
              _fertilizerType,
              DropdownOptions.fertilizerTypes,
              (val) {
                setState(() => _fertilizerType = val);
              },
            ),
            _buildNumberField(
              'Pesticide Usage (ml)',
              _pesticideController,
              0,
              1000,
            ),
            _buildNumberField(
              'Total Days',
              _totalDaysController,
              1,
              365,
              isInt: true,
            ),
            _buildDropdown(
              'Crop Disease Status',
              _diseaseStatus,
              DropdownOptions.diseaseStatus,
              (val) {
                setState(() => _diseaseStatus = val);
              },
            ),

            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _predictYield,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.analytics),
              label: Text(_isLoading ? 'Predicting...' : 'Predict Yield'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String? value,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.arrow_drop_down_circle),
        ),
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
        validator: (val) => val == null ? 'Please select $label' : null,
      ),
    );
  }

  Widget _buildNumberField(
    String label,
    TextEditingController controller,
    double min,
    double max, {
    bool isInt = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: !isInt),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.edit),
          helperText: 'Range: $min - $max',
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Please enter $label';
          }
          final num = double.tryParse(val);
          if (num == null) {
            return 'Please enter a valid number';
          }
          if (num < min || num > max) {
            return 'Value must be between $min and $max';
          }
          return null;
        },
      ),
    );
  }
}
