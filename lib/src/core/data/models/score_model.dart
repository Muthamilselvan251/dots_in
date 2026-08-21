class ScoreModel {
  final double value;
  final String label;
  final List<GaugeZone> zones;

  const ScoreModel({
    required this.value,
    required this.label,
    required this.zones,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
    value: (json['value'] as num).toDouble(),
    label: json['label'] as String,
    zones: (json['zones'] as List<dynamic>)
        .map((z) => GaugeZone.fromJson(z as Map<String, dynamic>))
        .toList(),
  );
}

class GaugeZone {
  final String name;
  final double from;
  final double to;
  final int colorValue;

  const GaugeZone({
    required this.name,
    required this.from,
    required this.to,
    required this.colorValue,
  });

  factory GaugeZone.fromJson(Map<String, dynamic> json) => GaugeZone(
    name: json['name'] as String,
    from: (json['from'] as num).toDouble(),
    to: (json['to'] as num).toDouble(),
    colorValue: json['color'] as int,
  );
}
