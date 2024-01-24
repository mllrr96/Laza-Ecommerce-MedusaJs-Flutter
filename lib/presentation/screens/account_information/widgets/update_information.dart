import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:laza/common/extensions/extensions.dart';

class UpdateInformation extends StatelessWidget {
  const UpdateInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          title: const Text('Update Information'),
          actions: [
            TextButton(
                onPressed: () {}, child: const Text('Save'))
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    hintText: 'First Name'),
              ),
              const Gap(10.0),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Last Name'),
              ),
            ],
          ),
        ),
        const Gap(10),
        Gap(context.viewInsets.bottom),
      ],
    );
  }
}
