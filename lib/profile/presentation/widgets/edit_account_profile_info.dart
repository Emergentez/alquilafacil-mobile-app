
import 'package:alquilafacil/profile/presentation/providers/profile_provider.dart';
import 'package:alquilafacil/profile/presentation/widgets/edit_account_info_field.dart';
import 'package:alquilafacil/profile/presentation/widgets/edit_profile_actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAccountProfileInfo extends StatefulWidget {
  final String name;
  final String motherName;
  final String fatherName;
  final String phoneNumber;
  final String documentNumber;
  final String dateOfBirth;
  final String bankAccount;
  final String interbankAccount;
  const EditAccountProfileInfo({
    super.key,
    required this.name,
    required this.motherName,
    required this.fatherName,
    required this.phoneNumber,
    required this.documentNumber,
    required this.dateOfBirth,
    required this.bankAccount,
    required this.interbankAccount,
  });

  @override
  State<EditAccountProfileInfo> createState() => _EditAccountProfileInfoState();
}

class _EditAccountProfileInfoState extends State<EditAccountProfileInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final profileProvider = context.read<ProfileProvider>();
    profileProvider.setCurrentName(widget.name);
    profileProvider.setCurrentFatherName(widget.fatherName);
    profileProvider.setCurrentMotherName(widget.motherName);
    profileProvider.setCurrentPhoneNumber(widget.phoneNumber);
    profileProvider.setCurrentDocumentNumber(widget.documentNumber);
    profileProvider.setCurrentDateOfBirth(widget.dateOfBirth);
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            EditAccountInfoField(
              accountParam: profileProvider.currentName,
              labelParam: "Ingrese el nuevo nombre",
              onChangeValue: (String value) {
                profileProvider.setCurrentName(value);
              },
            ),
            const SizedBox(height: 20),
            EditAccountInfoField(
              accountParam: profileProvider.currentFatherName,
              labelParam: "Ingrese el nuevo apellido paterno",
              onChangeValue: (String value) {
                profileProvider.setCurrentFatherName(value);
              },
            ),
            const SizedBox(height: 20),
            EditAccountInfoField(
              accountParam: profileProvider.currentMotherName,
              labelParam: "Ingrese el nuevo apellido materno",
              onChangeValue: (String value) {
                profileProvider.setCurrentMotherName(value);
              },
            ),
            const SizedBox(height: 20),
            EditAccountInfoField(
              accountParam: profileProvider.currentDocumentNumber,
              labelParam: "Ingrese el nuevo número de documento",
              onChangeValue: (String value) {
                profileProvider.setCurrentDocumentNumber(value);
              },
            ),
            const SizedBox(height: 20),
            EditAccountInfoField(
              accountParam: profileProvider.currentPhoneNumber,
              labelParam: "Ingrese el nuevo número de telefono",
              onChangeValue: (String value) {
                profileProvider.setCurrentPhoneNumber(value);
              },
            ),
            const SizedBox(height: 20),
            EditAccountInfoField(
              accountParam: profileProvider.currentDateOfBirth,
              labelParam: "Ingrese la nueva fecha de cumpleaños",
              onChangeValue: (String value) {
                profileProvider.setCurrentDateOfBirth(value);
              },
            ),
            const SizedBox(height: 20),
            EditAccountInfoField(
              accountParam: profileProvider.bankAccount,
              labelParam: "Ingrese la nueva cuenta bancaria",
              onChangeValue: (String value) {
                profileProvider.setBankAccount(value);
              },
            ),
            const SizedBox(height: 20),
            EditAccountInfoField(
              accountParam: profileProvider.interbankAccount,
              labelParam: "Ingrese la nueva cuenta interbancaria",
              onChangeValue: (String value) {
                profileProvider.setInterbankAccount(value);
              },
            ),
            const SizedBox(height: 20),
            const EditProfileActions(),
          ],
        ),
      ),
    );
  }
}


