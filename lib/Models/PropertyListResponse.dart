class PropertyListResponse {
  final int id;
  final String name;
  final String? imageURL;
  final String? fullDetail;
  final String? shortDescription;

  const PropertyListResponse(
      {required this.id,
      required this.name,
      required this.imageURL,
      required this.fullDetail,
      required this.shortDescription});

  factory PropertyListResponse.fromJson(Map<String, dynamic> jsonData) {
    return PropertyListResponse(
        id: jsonData["id"],
        name: jsonData["name"],
        imageURL: jsonData["imageURL"],
        fullDetail: jsonData["fullDetail"],
        shortDescription: jsonData["shortDescription"]);
  }
}
