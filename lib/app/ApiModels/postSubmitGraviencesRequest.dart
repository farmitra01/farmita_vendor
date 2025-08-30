class SubmitGrievanceRequest {
  final int categoryId;
  final String description;

  SubmitGrievanceRequest({required this.categoryId, required this.description});

  Map<String, String> toJson() {
    return {'category_id': categoryId.toString(), 'description': description};
  }
}
