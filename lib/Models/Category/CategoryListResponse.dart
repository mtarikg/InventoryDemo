class CategoryListResponse {
  final int id;
  final String name;

  const CategoryListResponse({
    required this.id,
    required this.name,
  });

  factory CategoryListResponse.fromJson(Map<String, dynamic> jsonData) {
    return CategoryListResponse(
      id: jsonData["id"],
      name: jsonData["name"],
    );
  }
}
