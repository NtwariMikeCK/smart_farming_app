class PredictionResult {
  final double predictedYield;
  final String unit;
  final String note;

  PredictionResult({
    required this.predictedYield,
    required this.unit,
    required this.note,
  });

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    return PredictionResult(
      predictedYield: (json['predicted_yield'] as num).toDouble(),
      unit: json['unit'] ?? 'kg per hectare',
      note: json['note'] ?? '',
    );
  }
}
