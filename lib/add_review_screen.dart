import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:laza/components/bottom_nav_button.dart';
import 'package:laza/components/custom_appbar.dart';
import 'package:laza/extensions/context_extension.dart';

import 'components/colors.dart';

class AddReviewScreen extends StatelessWidget {
  const AddReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 0, color: Colors.transparent));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle!,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: const CustomAppBar(title: 'Add Review'),
          bottomNavigationBar: BottomNavButton(label: 'Submit Review', onTap: () => Navigator.pop(context)),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: context.bodyLargeW500,
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            hintText: 'Type your name',
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: inputBorder,
                            hintStyle: TextStyle(color: ColorConstant.manatee),
                            fillColor: context.theme.cardColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How was your experience ?',
                          style: context.bodyLargeW500,
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          minLines: 6,
                          maxLines: null,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            hintText: 'Describe your experience?',
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: inputBorder,
                            hintStyle: TextStyle(color: ColorConstant.manatee),
                            fillColor: context.theme.cardColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Star',
                          style: context.bodyLargeW500,
                        ),
                        const SizedBox(height: 10.0),
                        Center(
                          child: RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
