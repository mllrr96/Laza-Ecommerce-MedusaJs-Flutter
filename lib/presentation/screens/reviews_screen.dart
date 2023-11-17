import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laza/common/colors.dart';
import 'package:laza/common/extensions/context_extension.dart';
import 'package:laza/presentation/screens/product_details.dart';
import '../components/index.dart';
import '../routes/app_router.dart';

@RoutePage()
class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = context.bottomViewPadding == 0.0 ? 30.0 : context.bottomViewPadding;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle!,
      child: Scaffold(
          appBar: const CustomAppBar(title: 'Reviews'),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPadding),
                  separatorBuilder: (_, __) => const SizedBox(height: 20.0),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('245 Reviews', style: context.bodyMediumW500),
                              const SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Text(
                                    '4.8',
                                    style: context.bodySmall,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, size: 14, color: Color(0xffFF981F)),
                                      const Icon(Icons.star, size: 14, color: Color(0xffFF981F)),
                                      const Icon(Icons.star, size: 14, color: Color(0xffFF981F)),
                                      Icon(Icons.star_border, size: 14, color: ColorConstant.manatee),
                                      Icon(Icons.star_border, size: 14, color: ColorConstant.manatee)
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5.0),
                            ],
                          ),
                          FilledButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 10.0)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                            ),
                            onPressed: () => context.router.push(const AddReviewRoute()),
                            child: const Row(
                              children: [
                                Icon(LazaIcons.edit_square, size: 18),
                                SizedBox(width: 5.0),
                                Text('Add Review'),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return const ReviewCard();
                  },
                  // 1 is for the add review
                  itemCount: 10 + 1,
                ),
              )
            ],
          )),
    );
  }
}
