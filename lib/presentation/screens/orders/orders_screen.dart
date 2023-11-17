import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza/di/di.dart';
import 'package:laza/presentation/components/index.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:laza/presentation/screens/orders/bloc/orders/orders_bloc.dart';
import 'package:medusa_store_flutter/store_models/orders/order.dart';

@RoutePage()
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  static const _pageSize = 20;

  final PagingController<int, Order> _pagingController = PagingController(firstPageKey: 0);
  final ordersBloc = getIt<OrdersBloc>();
  List<Order> orders = [];
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      ordersBloc.add(OrdersEvent.loadOrders(queryParameters: {
        'offset': pageKey,
        'limit': _pageSize,
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Orders'),
      body: BlocProvider(
        create: (context) => getIt<OrdersBloc>(),
        child: BlocListener<OrdersBloc, OrdersState>(
          listener: (context, state) {
            state.whenOrNull(
                loaded: (orders) {
                  final newItems = orders;
                  orders.addAll(orders);
                  final isLastPage = newItems.length < _pageSize;
                  if (isLastPage) {
                    _pagingController.appendLastPage(newItems);
                  } else {
                    final nextPageKey = 1 + orders.length;
                    _pagingController.appendPage(newItems, nextPageKey);
                  }
                },
                error: (error) => _pagingController.error = error);
          },
          child: PagedListView<int, Order>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Order>(
              itemBuilder: (context, order, index) => ListTile(
                title: Text('Order id: ${order.id ?? ''}'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
