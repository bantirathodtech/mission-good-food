abstract class BaseModel<T> {
  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json); // Instance method
  bool isValid() => true;
}