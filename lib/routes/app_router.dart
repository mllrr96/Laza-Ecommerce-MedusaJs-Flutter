import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:laza/cart_screen.dart';
import 'package:laza/dashboard_screen.dart';
import 'package:laza/home_screen.dart';
import 'package:laza/my_cards_screen.dart';
import 'package:laza/reset_password/verification_code_screen.dart';
import 'package:laza/wishlist_screen.dart';

import '../add_review_screen.dart';
import '../brand_products_screen.dart';
import '../models/brand.dart';
import '../models/product.dart';
import '../order_confirmed_screen.dart';
import '../product_details.dart';
import '../reset_password/forgot_password_screen.dart';
import '../reset_password/new_password_screen.dart';
import '../reviews_screen.dart';
import '../search_screen.dart';
import '../sign_in_screen.dart';
import '../sign_in_with_email.dart';
import '../sign_up_screen.dart';
import '../splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, page: SplashRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: SignInWithEmailRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: NewPasswordRoute.page),
        AutoRoute(page: VerificationCodeRoute.page),
        AutoRoute(page: SearchRoute.page, fullscreenDialog: true),
        AutoRoute(page: ReviewsRoute.page),
        AutoRoute(page: ProductDetailsRoute.page),
        AutoRoute(page: OrderConfirmedRoute.page),
        AutoRoute(page: BrandProductsRoute.page),
        AutoRoute(page: AddReviewRoute.page),
        AutoRoute(page: CartRoute.page),
        AutoRoute(
          page: DashboardRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: WishlistRoute.page),
            AutoRoute(page: CartRoute.page),
            AutoRoute(page: MyCardsRoute.page),
          ],
        ),
      ];
}
