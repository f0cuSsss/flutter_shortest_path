mixin JsonSerializable<T> {
  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json) {
    return {} as T;
  }
}
