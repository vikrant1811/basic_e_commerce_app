import 'dart:io';

class Profile {
  final String? phone;
  final String? email;
  final String? username;
  final String? name;
  final String? address;
  final String? city;
  final String? pincode;
  final String? state;
  final String? country;
  final String? avatar;
  final File? avatarFile;
  final String? businessName;
  final String? latitude;
  final String? longitude;

  Profile({
    this.phone,
    this.email,
    this.username,
    this.name,
    this.address,
    this.city,
    this.pincode,
    this.state,
    this.country,
    this.avatar,
    this.avatarFile,
    this.businessName,
    this.latitude,
    this.longitude,
  });

  // Factory method to create an instance from JSON data
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? 'Guest',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      pincode: json['pincode'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      avatar: json['avatar'] ?? '',
      businessName: json['businessName'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }

  // Convert the profile instance to a JSON map, omitting null values
  Map<String, dynamic> toJson() {
    final jsonMap = <String, dynamic>{};

    if (phone != null) jsonMap['phone'] = phone;
    if (email != null) jsonMap['email'] = email;
    if (username != null) jsonMap['username'] = username;
    if (name != null) jsonMap['name'] = name;
    if (address != null) jsonMap['address'] = address;
    if (city != null) jsonMap['city'] = city;
    if (pincode != null) jsonMap['pincode'] = pincode;
    if (state != null) jsonMap['state'] = state;
    if (country != null) jsonMap['country'] = country;
    if (avatar != null) jsonMap['avatar'] = avatar;
    if (businessName != null) jsonMap['businessName'] = businessName;
    if (latitude != null) jsonMap['latitude'] = latitude;
    if (longitude != null) jsonMap['longitude'] = longitude;

    return jsonMap;
  }

  // Define copyWith method for cloning and updating specific fields
  Profile copyWith({
    String? phone,
    String? email,
    String? username,
    String? name,
    String? address,
    String? city,
    String? pincode,
    String? state,
    String? country,
    String? avatar,
    File? avatarFile,
    String? businessName,
    String? latitude,
    String? longitude,
  }) {
    return Profile(
      phone: phone ?? this.phone,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      state: state ?? this.state,
      country: country ?? this.country,
      avatar: avatar ?? this.avatar,
      avatarFile: avatarFile ?? this.avatarFile,
      businessName: businessName ?? this.businessName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}