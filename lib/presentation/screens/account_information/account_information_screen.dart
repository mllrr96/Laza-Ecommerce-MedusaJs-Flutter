import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:laza/common/extensions/extensions.dart';
import 'package:laza/presentation/components/custom_appbar.dart';

import 'widgets/index.dart';

@RoutePage()
class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Account Information'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          const Gap(20.0),
          ListTile(
            leading: const Icon(Icons.account_box_rounded),
            onTap: () async {
              await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: context.theme.scaffoldBackgroundColor,
                  builder: (context) {
                    return UpdateInformation();
                  });
            },
            title: const Text(
              'Update Information',
            ),
          ),
          const Divider(height: 0),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.location_history),
            title: const Text(
              'Address Book',
            ),
          ),
          const Divider(height: 0),
          ListTile(
            leading: const Icon(Icons.security),
            onTap: () {},
            title: const Text(
              'Change Password',
            ),
          ),
        ],
      ),
    );
  }
}
