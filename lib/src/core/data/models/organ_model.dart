import 'package:dots_in/src/core/data/models/risk_item_model.dart';
import 'package:dots_in/src/core/data/models/score_model.dart';
import 'package:flutter/widgets.dart';

class OrganModel {
  final String id;
  final String name;
  final String imageAsset;
  final List<CalloutModel> callouts;
  final ScoreModel condition;
  final List<RiskVariant> riskVariants;
  final String recommendationTitle;
  final List<String> recommendationBullets;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<RiskItemModel> riskAssessment;

  const OrganModel({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.callouts,
    required this.condition,
    required this.riskVariants,
    required this.recommendationTitle,
    required this.recommendationBullets,
    required this.strengths,
    required this.weaknesses,
    required this.riskAssessment,
  });

  factory OrganModel.fromJson(Map<String, dynamic> json) => OrganModel(
    id: json['id'] as String,
    name: json['name'] as String,
    imageAsset: json['imageAsset'] as String,
    callouts: (json['callouts'] as List<dynamic>)
        .map((item) => CalloutModel.fromJson(item as Map<String, dynamic>))
        .toList(),
    condition: ScoreModel.fromJson(json['condition'] as Map<String, dynamic>),
    riskVariants: (json['riskVariants'] as List<dynamic>)
        .map((item) => RiskVariant.fromJson(item as Map<String, dynamic>))
        .toList(),
    recommendationTitle: json['recommendationTitle'] as String,
    recommendationBullets: List<String>.from(
      json['recommendationBullets'] as List<dynamic>,
    ),
    strengths: List<String>.from(json['strengths'] as List<dynamic>),
    weaknesses: List<String>.from(json['weaknesses'] as List<dynamic>),
    riskAssessment: (json['riskAssessment'] as List<dynamic>)
        .map((item) => RiskItemModel.fromJson(item as Map<String, dynamic>))
        .toList(),
  );
}

class RiskVariant {
  final String label;
  final ScoreModel score;

  const RiskVariant({required this.label, required this.score});

  factory RiskVariant.fromJson(Map<String, dynamic> json) => RiskVariant(
    label: json['label'] as String,
    score: ScoreModel.fromJson(json['score'] as Map<String, dynamic>),
  );
}

class CalloutModel {
  final String text;
  final bool isPositive;
  final Offset anchor;

  const CalloutModel({
    required this.text,
    required this.isPositive,
    required this.anchor,
  });

  factory CalloutModel.fromJson(Map<String, dynamic> json) => CalloutModel(
    text: json['text'] as String,
    isPositive: json['isPositive'] as bool,
    anchor: Offset(
      (json['anchorX'] as num).toDouble(),
      (json['anchorY'] as num).toDouble(),
    ),
  );
}
