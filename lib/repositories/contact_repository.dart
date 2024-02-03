import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:simple_2_pages_app/models/contact_model.dart';

class ContactRepository {
  Future<List<ContactModel>> getContactList() async {
    String jsonString =
        await rootBundle.loadString('assets/jsons/contact_list.json');
    final data = json.decode(jsonString);

    return (data as List? ?? []).map((e) => ContactModel.fromJson(e)).toList();
  }
}
