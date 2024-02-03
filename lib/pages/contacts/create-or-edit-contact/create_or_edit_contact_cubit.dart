import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_2_pages_app/models/contact_model.dart';
import 'package:simple_2_pages_app/pages/contacts/contact-list/contact_list_cubit.dart';

part 'create_or_edit_contact_state.dart';

class CreateOrEditContactCubit extends Cubit<CreateOrEditContactState> {
  final ContactListCubit contactListCubit;
  final int? contactIndex;

  CreateOrEditContactCubit({
    required this.contactListCubit,
    this.contactIndex,
  }) : super(
          CreateOrEditContactState.initial(
            contactIndex == null
                ? null
                : contactListCubit.state.contacts[contactIndex],
          ),
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
    if (contactIndex != null) {
      contactListCubit.editContact(
        index: contactIndex!,
        updatedContact: state.initContact!.copyWith(
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
