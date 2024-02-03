class ContactModel {
  String id;
  String firstName;
  String lastName;
  String? email;
  String? phoneNumber;
  String? dob;

  ContactModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phoneNumber,
    this.dob,
  });

  // Factory method to create a Contact instance from JSON
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      dob: json['dob'],
    );
  }

  ContactModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? dob,
  }) {
    return ContactModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dob: dob ?? this.dob,
    );
  }
}