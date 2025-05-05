import 'dart:convert';
import 'dart:io';

class Address {
  final String fullName;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String phone;
  final bool isDefault;

  Address({
    required this.fullName,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.phone,
    this.isDefault = false,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    fullName: json["fullName"],
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postalCode"],
    country: json["country"],
    phone: json["phone"],
    isDefault: json["isDefault"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "city": city,
    "state": state,
    "postalCode": postalCode,
    "country": country,
    "phone": phone,
    "isDefault": isDefault,
  };
}

class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? role;
  final String? status;
  final String? avatar;
  final File? avatarFile;
  final String? phone;
  final List<Address>? addresses;
  final bool? emailVerified;
  final DateTime? lastLogin;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.role,
    this.status,
    this.avatar,
    this.avatarFile,
    this.phone,
    this.addresses,
    this.emailVerified,
    this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] ?? '',
    email: json["email"] ?? '',
    firstName: json["firstName"] ?? '',
    lastName: json["lastName"] ?? '',
    role: json["role"],
    status: json["status"],
    avatar: json["avatar"],
    phone: json["phone"],
    addresses: json["addresses"] != null
        ? List<Address>.from(
        json["addresses"].map((x) => Address.fromJson(x)))
        : null,
    emailVerified: json["emailVerified"],
    lastLogin: json["lastLogin"] != null
        ? DateTime.parse(json["lastLogin"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "role": role,
    "status": status,
    "avatar": avatar,
    "phone": phone,
    "addresses":
    addresses?.map((address) => address.toJson()).toList(),
    "emailVerified": emailVerified,
    "lastLogin": lastLogin?.toIso8601String(),
  };

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
    String? status,
    String? avatar,
    File? avatarFile,
    String? phone,
    List<Address>? addresses,
    bool? emailVerified,
    DateTime? lastLogin,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        role: role ?? this.role,
        status: status ?? this.status,
        avatar: avatar ?? this.avatar,
        avatarFile: avatarFile ?? this.avatarFile,
        phone: phone ?? this.phone,
        addresses: addresses ?? this.addresses,
        emailVerified: emailVerified ?? this.emailVerified,
        lastLogin: lastLogin ?? this.lastLogin,
      );
}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
