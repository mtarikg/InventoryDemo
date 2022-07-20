class PersonnelListResponse {
  final int id;
  final String fullName;
  final String username;

  const PersonnelListResponse(
      {required this.id, required this.fullName, required this.username});

  factory PersonnelListResponse.fromJson(Map<String, dynamic> jsonData) {
    return PersonnelListResponse(
        id: jsonData["id"],
        fullName: jsonData["fullName"],
        username: jsonData["username"]);
  }
}
