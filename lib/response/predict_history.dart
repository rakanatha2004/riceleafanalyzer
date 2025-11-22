import 'dart:convert';

class PredictHistory {
  int? id;
  String? filename;
  String? predictedClass;
  double? confidence;
  Probabilities? probabilities;
  String? imageUrl;
  DateTime? createdAt;
  DiseaseDetail? diseaseDetail;

  PredictHistory({
    this.id,
    this.filename,
    this.predictedClass,
    this.confidence,
    this.probabilities,
    this.imageUrl,
    this.createdAt,
    this.diseaseDetail,
  });

  factory PredictHistory.fromRawJson(String str) =>
      PredictHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PredictHistory.fromJson(Map<String, dynamic> json) => PredictHistory(
    id: json["id"],
    filename: json["filename"],
    predictedClass: json["predicted_class"],
    confidence: json["confidence"]?.toDouble(),
    probabilities: json["probabilities"] == null
        ? null
        : Probabilities.fromJson(json["probabilities"]),
    imageUrl: json["image_url"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    diseaseDetail: json["disease_detail"] == null
        ? null
        : DiseaseDetail.fromJson(json["disease_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "filename": filename,
    "predicted_class": predictedClass,
    "confidence": confidence,
    "probabilities": probabilities?.toJson(),
    "image_url": imageUrl,
    "created_at": createdAt?.toIso8601String(),
    "disease_detail": diseaseDetail?.toJson(),
  };
}

class DiseaseDetail {
  String? ringkasan;
  List<String>? pencegahan;
  List<String>? pengobatan;

  DiseaseDetail({this.ringkasan, this.pencegahan, this.pengobatan});

  factory DiseaseDetail.fromRawJson(String str) =>
      DiseaseDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiseaseDetail.fromJson(Map<String, dynamic> json) => DiseaseDetail(
    ringkasan: json["ringkasan"],
    pencegahan: json["pencegahan"] == null
        ? []
        : List<String>.from(json["pencegahan"]!.map((x) => x)),
    pengobatan: json["pengobatan"] == null
        ? []
        : List<String>.from(json["pengobatan"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ringkasan": ringkasan,
    "pencegahan": pencegahan == null
        ? []
        : List<dynamic>.from(pencegahan!.map((x) => x)),
    "pengobatan": pengobatan == null
        ? []
        : List<dynamic>.from(pengobatan!.map((x) => x)),
  };
}

class Probabilities {
  double? brownSpot;
  double? leafSmut;
  double? healthyLeaf;
  double? bacterial;
  double? blast;

  Probabilities({
    this.brownSpot,
    this.leafSmut,
    this.healthyLeaf,
    this.bacterial,
    this.blast,
  });

  factory Probabilities.fromRawJson(String str) =>
      Probabilities.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Probabilities.fromJson(Map<String, dynamic> json) => Probabilities(
    brownSpot: json["BrownSpot"]?.toDouble(),
    leafSmut: json["LeafSmut"]?.toDouble(),
    healthyLeaf: json["Healthy_Leaf"]?.toDouble(),
    bacterial: json["Bacterial"]?.toDouble(),
    blast: json["Blast"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "BrownSpot": brownSpot,
    "LeafSmut": leafSmut,
    "Healthy_Leaf": healthyLeaf,
    "Bacterial": bacterial,
    "Blast": blast,
  };
}
