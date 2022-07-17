class PersonnelPropertyListResponse {
  final int propertyID;
  final String dueOn;

  const PersonnelPropertyListResponse(
      {required this.propertyID, required this.dueOn});

  factory PersonnelPropertyListResponse.fromJson(
      Map<String, dynamic> jsonData) {
    return PersonnelPropertyListResponse(
        propertyID: jsonData["propertyID"], dueOn: jsonData["dueOn"]);
  }
}
