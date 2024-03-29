import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_2_pages_app/models/contact_model.dart';
import 'package:simple_2_pages_app/pages/contacts/contact-list/contact_list_cubit.dart';
import 'package:simple_2_pages_app/pages/contacts/create-or-edit-contact/create_or_edit_contact_cubit.dart';
import 'package:simple_2_pages_app/utils/borders.dart';
import 'package:simple_2_pages_app/utils/colors.dart';

class CreateOrEditContactPage extends StatelessWidget {
  static const route = '/create_or_edit_contact_page';

  const CreateOrEditContactPage({
    super.key,
    this.contact,
  });

  final ContactModel? contact;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateOrEditContactCubit(
        contactListCubit: context.read<ContactListCubit>(),
        contact: contact,
      ),
      child: const _View(),
    );
  }
}

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 80,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
              child: Text(
                'Cancel',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: kClrFF8C00,
                ),
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                if (formKey.currentState?.validate() == true) {
                  context.read<CreateOrEditContactCubit>().save();
                  Navigator.pop(context);
                }
              },
              child: const SizedBox(
                width: 70,
                child: Center(
                  child: Text(
                    'Save',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      color: kClrFF8C00,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: _Form(formKey),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form(this.formKey);

  final GlobalKey<FormState> formKey;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {

  String? emptyFieldValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Cannot be empty';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrEditContactCubit, CreateOrEditContactState>(
        buildWhen: (previous, current) =>
            previous.initContact != current.initContact,
        builder: (context, state) {
          debugPrint('cek  state.initContact?.firstName : ${ state.initContact?.firstName}');
          debugPrint('cek  state.initContact?.lastName : ${ state.initContact?.lastName}');
          final focus = FocusScope.of(context);
          return ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kClrFF8C00,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Main Information',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'First Name',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TextFormField(
                      // focusNode: firstNameFocusNode,
                      autofocus: true,
                      initialValue: state.initContact?.firstName,
                      validator: emptyFieldValidator,
                      onChanged: (String val) {
                        context
                            .read<CreateOrEditContactCubit>()
                            .updateState(firstName: val);
                      },
                      onEditingComplete: focus.nextFocus,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: kDefaultInputBorder,
                        focusedBorder: kDefaultInputBorder,
                        enabledBorder: kDefaultInputBorder,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Last Name',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: TextFormField(
                    initialValue: state.initContact?.lastName,
                    validator: emptyFieldValidator,
                    onChanged: (String val) {
                      context
                          .read<CreateOrEditContactCubit>()
                          .updateState(lastName: val);
                    },
                        onEditingComplete: focus.nextFocus,
                        textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: kDefaultInputBorder,
                      focusedBorder: kDefaultInputBorder,
                      enabledBorder: kDefaultInputBorder,
                    ),
                  )),
                  const SizedBox(
                    width: 12,
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Sub Information',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: TextFormField(
                    initialValue: state.initContact?.email,
                    onChanged: (String val) {
                      context
                          .read<CreateOrEditContactCubit>()
                          .updateState(email: val);
                    },
                        onEditingComplete: focus.nextFocus,
                        textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: kDefaultInputBorder,
                      focusedBorder: kDefaultInputBorder,
                      enabledBorder: kDefaultInputBorder,
                    ),
                  )),
                  const SizedBox(
                    width: 12,
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: TextFormField(
                    initialValue: state.initContact?.phoneNumber,
                    onChanged: (String val) {
                      context
                          .read<CreateOrEditContactCubit>()
                          .updateState(phoneNum: val);
                    },
                        onEditingComplete: focus.nextFocus,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: kDefaultInputBorder,
                      focusedBorder: kDefaultInputBorder,
                      enabledBorder: kDefaultInputBorder,
                    ),
                  )),
                  const SizedBox(
                    width: 12,
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'DOB',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: TextFormField(
                    initialValue: state.initContact?.dob,
                    onChanged: (String val) {
                      context
                          .read<CreateOrEditContactCubit>()
                          .updateState(dob: val);
                    },
                        onEditingComplete: focus.unfocus,
                        textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      border: kDefaultInputBorder,
                      focusedBorder: kDefaultInputBorder,
                      enabledBorder: kDefaultInputBorder,
                    ),
                  )),
                  const SizedBox(
                    width: 12,
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          );
        });
  }
}
