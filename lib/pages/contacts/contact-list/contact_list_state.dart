part of 'contact_list_cubit.dart';

class ContactListState {
  final RequestState fetchContactListState;
  final List<ContactModel> contacts;
  final String searchQuery;
  final String? errMsg;


  ContactListState({
    this.fetchContactListState = RequestState.loading,
    this.contacts = const [],
    this.searchQuery = '',
    this.errMsg,
  });

    // factory ContactListState.initial() {
  //   return ContactListState(
  //   );
  // }

  ContactListState update({
    RequestState? fetchContactListState,
    List<ContactModel>? contacts,
    String? searchQuery,
    String? errMsg,

  }) {
    return ContactListState(
      fetchContactListState: fetchContactListState ?? this.fetchContactListState,
      contacts: contacts ?? this.contacts,
      searchQuery: searchQuery ?? this.searchQuery,
      errMsg: errMsg,
    );
  }
}