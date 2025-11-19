class PersonnelPropertyListResponse {
  final int propertyID;
  final String dueOn;
  final bool isWaiting;

  const PersonnelPropertyListResponse(
      {required this.propertyID, required this.dueOn, required this.isWaiting});

  factory PersonnelPropertyListResponse.fromJson(
      Map<String, dynamic> jsonData) {
    return PersonnelPropertyListResponse(
        propertyID: jsonData["propertyID"],
        dueOn: jsonData["dueOn"],
        isWaiting: jsonData["isWaiting"]);
  }
}
