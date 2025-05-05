class User {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final int? points;
  final String? address;
  final String? profilePicture;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.profilePicture,
      this.points});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        address: json['address'],
        email: json['email'],
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        profilePicture: json['profile_picture'],
        points: json['points']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['profile_picture'] = profilePicture;
    data['points'] = points;
    return data;
  }
}
