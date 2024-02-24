class Success
{
  bool? success;

  Success({this.success}){}

  Success.fromJson(Map<String, dynamic> json)
  {
    this.success = json["success"];
  }

}
