
class UserModel {
  String name = "";
  String yeargroup = "2024";

  // Constructor
  UserModel(
      {required this.name,
        required this.yeargroup
      });

  UserModel.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['name'],
        yeargroup = parsedJSON['yeargroup'];
}