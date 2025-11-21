class PredictionInput {
  final String region;
  final String crop_type;
  final double soil_moisture;
  final double soil_pH;
  final double temperature_C;
  final double rainfall_mm;
  final double humidity;
  final double sunlight_hours;
  final String irrigation_type;
  final String fertilizer_type;
  final double pesticide_usage_ml;
  final int total_days;
  final String crop_disease_status;

  PredictionInput({
    required this.region,
    required this.crop_type,
    required this.soil_moisture,
    required this.soil_pH,
    required this.temperature_C,
    required this.rainfall_mm,
    required this.humidity,
    required this.sunlight_hours,
    required this.irrigation_type,
    required this.fertilizer_type,
    required this.pesticide_usage_ml,
    required this.total_days,
    required this.crop_disease_status,
  });

  Map<String, dynamic> toJson() {
    return {
      'region': region,
      'crop_type': crop_type,
      'soil_moisture_%': soil_moisture,
      'soil_pH': soil_pH,
      'temperature_C': temperature_C,
      'rainfall_mm': rainfall_mm,
      'humidity_%': humidity,
      'sunlight_hours': sunlight_hours,
      'irrigation_type': irrigation_type,
      'fertilizer_type': fertilizer_type,
      'pesticide_usage_ml': pesticide_usage_ml,
      'total_days': total_days,
      'crop_disease_status': crop_disease_status,
    };
  }
}
