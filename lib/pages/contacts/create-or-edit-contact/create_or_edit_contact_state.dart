part of 'create_or_edit_contact_cubit.dart';

class CreateOrEditContactState {
  final ContactModel? initContact;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phoneNum;
  final String? dob;


  CreateOrEditContactState({
    this.initContact,
    this.firstName = '',
    this.lastName = '',
    this.email,
    this.phoneNum,
    this.dob,
  });


  @override
  String toString() {
    return 'CreateOrEditContactState{initContact: $initContact, firstName: $firstName, lastName: $lastName, email: $email, phoneNum: $phoneNum, dob: $dob}';
  }

  factory CreateOrEditContactState.initial(ContactModel? contact) {
    return CreateOrEditContactState(
      initContact: contact,
      firstName: contact?.firstName ?? '',
      lastName: contact?.lastName ?? '',
      email: contact?.email,
      phoneNum: contact?.phoneNumber,
      dob: contact?.dob,
    );
  }

  CreateOrEditContactState update({
    ContactModel? initContact,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNum,
    String? dob,

  }) {
    return CreateOrEditContactState(
      initContact: initContact ?? this.initContact,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNum: phoneNum ?? this.phoneNum,
      dob: dob ?? this.dob,
    );
  }
}