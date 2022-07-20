class PropertyListResponse {
  final int id;
  final String name;
  final String? imageURL;
  final int quantity;
  final String? fullDetail;
  final String? shortDescription;
  final int categoryID;

  const PropertyListResponse(
      {required this.id,
      required this.name,
      required this.imageURL,
      required this.quantity,
      required this.fullDetail,
      required this.shortDescription,
      required this.categoryID});

  factory PropertyListResponse.fromJson(Map<String, dynamic> jsonData) {
    return PropertyListResponse(
        id: jsonData["id"],
        name: jsonData["name"],
        imageURL: jsonData["imageURL"],
        quantity: jsonData["quantity"],
        fullDetail: jsonData["fullDetail"],
        shortDescription: jsonData["shortDescription"],
        categoryID: jsonData["categoryID"]);
  }
}
