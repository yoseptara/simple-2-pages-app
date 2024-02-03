import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_2_pages_app/models/contact_model.dart';
import 'package:simple_2_pages_app/pages/contacts/contact-list/contact_list_cubit.dart';
import 'package:simple_2_pages_app/pages/contacts/create-or-edit-contact/create_or_edit_contact_page.dart';
import 'package:simple_2_pages_app/utils/colors.dart';
import 'package:simple_2_pages_app/utils/enums.dart';

class ContactListPage extends StatelessWidget {
  static const route = '/contact_list_page';

  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return const _View();
    });
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.search,
            size: 36,
            color: kClrFF8C00,
          ),
          // Left-side icon (e.g., menu icon)
          onPressed: () {
            debugPrint('Left-side icon pressed');
          },
        ),
        centerTitle: true,
        title: const Text(
          'Contacts',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.add,
                size: 36,
                color: kClrFF8C00,
              ),
              // Left-side icon (e.g., menu icon)
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateOrEditContactPage(),
                  ),
                );
              },
            );
          }),
        ],
      ),
      body: const _ContactList(),
    );
  }
}

class _ContactList extends StatelessWidget {
  const _ContactList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactListCubit, ContactListState>(
        buildWhen: (previous, current) =>
            previous.fetchContactListState != current.fetchContactListState ||
            previous.contacts != current.contacts ||
            previous.searchQuery != current.searchQuery,
        builder: (context, state) {
          if (state.fetchContactListState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: kClrFF8C00,
              ),
            );
          }

          if (state.contacts.isEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          }

          return RefreshIndicator(
            onRefresh: context.read<ContactListCubit>().getContactList,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                final width = (MediaQuery.of(context).size.width - 12 - 32) / 2;
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateOrEditContactPage(
                            contact: contact,
                          ),
                        ),
                      );
                    },
                    child: _ContactItem(width: width, contact: contact));
              },
            ),
          );
        });
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    required this.width,
    required this.contact,
  });

  final double width;
  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.black38),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kClrFF8C00,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            '${contact.firstName} ${contact.lastName}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
