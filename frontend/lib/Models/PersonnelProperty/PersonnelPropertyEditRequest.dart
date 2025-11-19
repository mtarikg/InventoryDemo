class PersonnelPropertyEditRequest {
  final int userID;
  final int propertyID;
  final bool isWaiting;

  const PersonnelPropertyEditRequest({
    required this.userID,
    required this.propertyID,
    required this.isWaiting,
  });
}
