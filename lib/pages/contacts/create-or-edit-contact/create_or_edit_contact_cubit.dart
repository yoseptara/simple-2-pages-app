import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_2_pages_app/models/contact_model.dart';
import 'package:simple_2_pages_app/pages/contacts/contact-list/contact_list_cubit.dart';

part 'create_or_edit_contact_state.dart';

class CreateOrEditContactCubit extends Cubit<CreateOrEditContactState> {
  final ContactListCubit contactListCubit;
  final ContactModel? contact;

  CreateOrEditContactCubit({
    required this.contactListCubit,
    this.contact,
  }) : super(
      CreateOrEditContactState.initial(contact)
        );

  void updateState({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNum,
    String? dob,
  }) {
    emit(
      state.update(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNum: phoneNum,
        dob: dob,
      ),
    );
  }

  void save() {
    if (contact != null) {
      debugPrint('cek state.firstName : ${state.firstName}');
      debugPrint('cek state.lastName : ${state.lastName}');
      contactListCubit.editContact(
        state.initContact!.copyWith(
          firstName: state.firstName,
          lastName: state.lastName,
          email: state.email,
          phoneNumber: state.phoneNum,
          dob: state.dob,
        ),
      );
      return;
    }

    contactListCubit.addContact(
      ContactModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        firstName: state.firstName,
        lastName: state.lastName,
        email: state.email,
        phoneNumber: state.phoneNum,
        dob: state.dob,
      ),
    );
  }
}
