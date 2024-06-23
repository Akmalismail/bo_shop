import 'package:bo_mart/common/constants/styles.dart';
import 'package:bo_mart/domain/models/cart_item_model.dart';
import 'package:bo_mart/presentation/cart/provider/cart_provider.dart';
import 'package:bo_mart/presentation/cart/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartList extends ConsumerWidget {
  const CartList({
    required this.items,
    super.key,
  });

  final List<CartItemModel> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final cartItems = ref.watch(cartNotifierProvider);

    return DecoratedSliver(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
      ),
      sliver: SliverList.builder(
        itemCount: cartItems.length + 1,
        itemBuilder: (context, index) {
          /// if last item return nothing
          if (index == items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p15,
                vertical: AppPadding.p10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total'),
                  Text(
                    'RM 500.00',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          return Dismissible(
            key: ObjectKey(items[index]),
            background: Container(
              color: AppColors.red,
            ),
            onDismissed: (_) {
              ref.read(cartNotifierProvider.notifier).removeItem(index: index);
            },
            child: Column(
              children: [
                CartItem(
                  item: items[index],
                ),
                const Divider(
                  height: 1,
                  indent: AppPadding.p15,
                  endIndent: AppPadding.p15,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
