import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:laza/presentation/screens/index.dart';
import 'package:medusa_store_flutter/store_models/products/product.dart';
import 'package:medusa_store_flutter/store_models/products/product_collection.dart';

import '../screens/home/home_screen.dart';
import '../screens/orders/orders_screen.dart';

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
        AutoRoute(page: CollectionRoute.page),
        AutoRoute(page: AddReviewRoute.page),
        AutoRoute(page: CartRoute.page),
        AutoRoute(page: OrdersRoute.page),
        AutoRoute(
          page: DashboardRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: SearchRoute.page),
            AutoRoute(page: WishlistRoute.page),
            AutoRoute(page: CartRoute.page),
          ],
        ),
      ];
}
