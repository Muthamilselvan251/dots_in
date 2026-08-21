import 'dart:convert';
import 'package:dots_in/src/core/constants/app_assets.dart';
import 'package:dots_in/src/core/data/models/metric_model.dart';
import 'package:dots_in/src/core/data/models/organ_model.dart';
import 'package:dots_in/src/core/data/models/score_model.dart';
import 'package:flutter/services.dart';

class LocalJsonDataSource {
  Future<Map<String, dynamic>> _load(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    return json.decode(raw) as Map<String, dynamic>;
  }

  Future<List<OrganModel>> getOrgans() async {
    final data = await _load(AppAssets.healthData);
    return (data['organs'] as List<dynamic>)
        .map((e) => OrganModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<MetricModel>> getBloodMetrics() async {
    final data = await _load(AppAssets.healthData);
    return (data['bloodMetrics'] as List<dynamic>)
        .map((e) => MetricModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<MetricModel>> getHormones() async {
    final data = await _load(AppAssets.healthData);
    return (data['hormones'] as List<dynamic>)
        .map((e) => MetricModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ScoreModel> getWellnessScore() async {
    final data = await _load(AppAssets.healthData);
    return ScoreModel.fromJson(data['wellnessScore'] as Map<String, dynamic>);
  }
}
