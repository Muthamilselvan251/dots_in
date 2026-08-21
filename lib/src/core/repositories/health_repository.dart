import 'package:dots_in/src/core/data/models/metric_model.dart';
import 'package:dots_in/src/core/data/models/organ_model.dart';
import 'package:dots_in/src/core/data/models/score_model.dart';
import 'package:dots_in/src/core/datasources/local_json_datasource.dart';

class HealthRepository {
  final LocalJsonDataSource _source;
  HealthRepository(this._source);

  Future<List<OrganModel>> fetchOrgans() => _source.getOrgans();
  Future<OrganModel> fetchOrganById(String id) async =>
      (await fetchOrgans()).firstWhere(
        (organ) => organ.id == id,
        orElse: () => throw StateError('Organ not found: $id'),
      );
  Future<List<MetricModel>> fetchBloodMetrics() => _source.getBloodMetrics();
  Future<List<MetricModel>> fetchHormones() => _source.getHormones();
  Future<ScoreModel> fetchWellnessScore() => _source.getWellnessScore();

  Future<MetricModel> fetchMetricById(String id) async {
    final metrics = [...await fetchBloodMetrics(), ...await fetchHormones()];
    return metrics.firstWhere(
      (metric) => metric.id == id,
      orElse: () => throw StateError('Metric not found: $id'),
    );
  }
}
