class PersonnelPropertyAddRequest {
  final int personnelID;
  final int propertyID;
  final DateTime dueOn;
  final bool isWaiting;

  const PersonnelPropertyAddRequest(
      {required this.personnelID,
      required this.propertyID,
      required this.dueOn,
      required this.isWaiting});
}
