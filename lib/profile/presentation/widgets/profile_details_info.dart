import 'package:alquilafacil/auth/presentation/screens/login.dart';
import 'package:alquilafacil/profile/presentation/providers/profile_provider.dart';
import 'package:alquilafacil/profile/presentation/widgets/account_profile_info.dart';
import 'package:alquilafacil/profile/presentation/widgets/avatar_details.dart';
import 'package:alquilafacil/profile/presentation/widgets/profile_actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/ui/theme/main_theme.dart';
import 'edit_account_profile_info.dart';

class ProfileDetailsInfo extends StatelessWidget {
  final String fullName;
  final String phoneNumber;
  final String documentNumber;
  final String dateOfBirth;
  final String bankAccount;
  final String interbankAccount;
  const ProfileDetailsInfo({
        super.key,
        required this.fullName,
        required this.phoneNumber,
        required this.documentNumber,
        required this.dateOfBirth,
        required this.bankAccount,
        required this.interbankAccount,
      });

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    return !profileProvider.isEditMode ? Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      padding: const EdgeInsets.only(top: 70, bottom: 10),
      width: double.infinity,
      height: 600,
      decoration:  BoxDecoration(
        color: MainTheme.background(context),
        borderRadius: BorderRadius.circular(15)
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarDetails(fullName: fullName),
          const SizedBox(height: 10),
          AccountProfileInfo(phoneNumber: phoneNumber, documentNumber: documentNumber, dateOfBirth: dateOfBirth, bankAccount: bankAccount, interbankAccount: interbankAccount),
          const ProfileActions()
        ],
      ),
    ):   Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          width: double.infinity,
          height: 1050,
          decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
          ),
          child: EditAccountProfileInfo(
            name: fullName.split(" ")[0],
            fatherName: fullName.split(" ")[2],
            motherName: fullName.split(" ")[3],
            documentNumber: documentNumber,
            dateOfBirth: dateOfBirth,
            phoneNumber: phoneNumber,
            bankAccount: bankAccount,
            interbankAccount: interbankAccount
          )
    );
  }
}
