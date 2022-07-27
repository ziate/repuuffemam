class UserInfoModel {
  int id;
  String fName;
  String lName;
  String email;
  String image;
  String user_name;
  String phone;
  String password;
  String date_of_birth;
  String address;
  String country;
  String city;
  String facebook;
  int gender;
  int orderCount;
  int memberSinceDays;

  UserInfoModel(
      {this.id,
      this.fName,
      this.lName,
      this.email,
      this.image,
      this.phone,
      this.user_name,
      this.password,
      this.orderCount,
      this.date_of_birth,
      this.address,
      this.country,
      this.city,
      this.facebook,
      this.gender,
      this.memberSinceDays});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
    password = json['password'];
    orderCount = json['order_count'];
    memberSinceDays = json['member_since_days'];
    date_of_birth = json['date_of_birth'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    gender = json['gender'];
    facebook = json['facebook'];
    user_name = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['email'] = this.email;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['order_count'] = this.orderCount;
    data['member_since_days'] = this.memberSinceDays;
    data['date_of_birth'] = this.date_of_birth;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['user_name'] = this.user_name;

    return data;
  }
}
