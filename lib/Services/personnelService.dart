import 'package:inventory_demo/Services/apiService.dart';
import '../Models/PropertyListResponse.dart';

class PersonnelService {
  ApiService apiService = ApiService();

  Future<PropertyListResponse?> getPropertyByCategory(
      int propertyID, int categoryID) async {
    var property = await apiService.getPropertyByID(propertyID);

    if (property.categoryID == categoryID) {
      return property;
    } else {
      return null;
    }
  }
}
