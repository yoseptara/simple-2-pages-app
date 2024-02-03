import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_2_pages_app/models/contact_model.dart';
import 'package:simple_2_pages_app/repositories/contact_repository.dart';
import 'package:simple_2_pages_app/utils/enums.dart';

part 'contact_list_state.dart';

class ContactListCubit extends Cubit<ContactListState> {
  final ContactRepository contactRepo;

  ContactListCubit({
    required this.contactRepo,
  }) : super(
          ContactListState(),
        );

  Future<void> getContactList() async {
    try {
      emit(state.update(fetchContactListState: RequestState.loading));
      final res = await contactRepo.getContactList();

      emit(
        state.update(
          fetchContactListState: RequestState.success,
          contacts: res,
        ),
      );
    } catch (e) {
      emit(
        state.update(
          fetchContactListState: RequestState.failure,
        ),
      );
      rethrow;
    }
  }

  void addContact(ContactModel newContact) {
    emit(state.update(contacts: [...state.contacts, newContact]));
  }

  void editContact(ContactModel updatedContact) {
   final contacts = List.of(state.contacts);
   final index = contacts.lastIndexWhere((element) => element.id == updatedContact.id,);
   contacts[index] = updatedContact;

   emit(state.update(contacts: contacts));
  }
}
