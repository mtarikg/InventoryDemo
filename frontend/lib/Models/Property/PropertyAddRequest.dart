class PropertyAddRequest {
  final String name;
  final String? imageURL;
  final int quantity;
  final String shortDescription;
  final String? fullDetail;
  final int categoryID;

  const PropertyAddRequest(
      {required this.name,
      required this.imageURL,
      required this.quantity,
      required this.shortDescription,
      required this.fullDetail,
      required this.categoryID});
}
