class PropertyEditRequest {
  final String? imageURL;
  final int quantity;
  final String shortDescription;
  final String? fullDetail;

  const PropertyEditRequest(
      {this.imageURL,
      required this.quantity,
      required this.shortDescription,
      this.fullDetail});
}
