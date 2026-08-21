enum RiskStatus { low, moderate, high }

class RiskItemModel {
  final String name;
  final String subtitle;
  final double score;
  final RiskStatus status;

  const RiskItemModel({
    required this.name,
    required this.subtitle,
    required this.score,
    required this.status,
  });

  factory RiskItemModel.fromJson(Map<String, dynamic> json) => RiskItemModel(
    name: json['name'] as String,
    subtitle: json['subtitle'] as String,
    score: (json['score'] as num).toDouble(),
    status: RiskStatus.values.byName(json['status'] as String),
  );
}
