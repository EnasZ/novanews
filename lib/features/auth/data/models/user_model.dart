import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String fullName;
  
  @HiveField(1)
  final String email;
  
  @HiveField(2)
  final String password;
  
  @HiveField(3)
  final int age;
  
  @HiveField(4)
  final String country;

  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    this.age = 23,
    this.country = 'Egypt',
  });
}
