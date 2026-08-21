import 'package:dots_in/src/core/data/models/score_model.dart';

class MetricModel {
  final String id;
  final String title;
  final double value;
  final String unit;
  final ScoreModel gauge;
  final List<ImpactedParameter> impactedParameters;
  final String aboutTitle;
  final String aboutBody;

  const MetricModel({
    required this.id,
    required this.title,
    required this.value,
    required this.unit,
    required this.gauge,
    required this.impactedParameters,
    required this.aboutTitle,
    required this.aboutBody,
  });

  factory MetricModel.fromJson(Map<String, dynamic> json) => MetricModel(
    id: json['id'] as String,
    title: json['title'] as String,
    value: (json['value'] as num).toDouble(),
    unit: json['unit'] as String,
    gauge: ScoreModel.fromJson(json['gauge'] as Map<String, dynamic>),
    impactedParameters: (json['impactedParameters'] as List<dynamic>)
        .map((item) => ImpactedParameter.fromJson(item as Map<String, dynamic>))
        .toList(),
    aboutTitle: json['aboutTitle'] as String,
    aboutBody: json['aboutBody'] as String,
  );
}

class ImpactedParameter {
  final String title;
  final String subtitle;

  const ImpactedParameter({required this.title, required this.subtitle});

  factory ImpactedParameter.fromJson(Map<String, dynamic> json) =>
      ImpactedParameter(
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
      );
}
