import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sippy_ca/core/app_colors.dart';
import 'package:sippy_ca/features/auth/presentation/provider/auth_provider.dart';
import 'package:sippy_ca/features/cart_page.dart/presentation/provider/cart_provider.dart';
import 'package:sippy_ca/features/homepage/data/models/beverage.dart';
import 'package:sippy_ca/features/homepage/presentation/provider/invite_provider.dart';
import 'package:sippy_ca/features/product/presentation/provider/product_provider.dart';
import 'package:sippy_ca/features/widgets/image.dart';
import 'package:sippy_ca/utils/font_class.dart';
import 'package:sippy_ca/utils/utility_class.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.product});
  final BeverageItem? product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  DateTime? startDateBooking;
  DateTime? endDateBooking;

  int _itemCount = 1;
  String itemValue = "";

  @override
  void initState() {
    context.read<InviteProvider>().fetchCollabs(
        context.read<AuthProvider>().currentUserState!.email!, () {}, () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final user = context.read<AuthProvider>().currentUserState;
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  leadingWidth: 60,
                  leading: Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.lightColor,
                        radius: 10,
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: AppColors.darkColor,
                        ),
                      ),
                    ),
                  ),
                  collapsedHeight: kToolbarHeight + 10,
                  expandedHeight: 350.0, // Height when expanded
                  floating: false,
                  pinned: true, // Keeps the app bar pinned when collapsed
                  flexibleSpace: FlexibleSpaceBar(
                      background:
                          ImageWidget(imageUrl: UtilityClass.images[0])),
                  actions: [
                    CircleAvatar(
                      backgroundColor: AppColors.lightColor,
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.darkColor,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ];
            },
            body: SingleChildScrollView(
                child: Padding(
              padding: UtilityClass.horizontalAndVerticalPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product!.name,
                    style: FontClass.headerStyleBlack,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "\$${product.price.toString()}",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    product.description,
                    style: FontClass.priceFontMedium,
                  ),
                ],
              ),
            ))
            //: Container(),
            ),
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.zero,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                border: BorderDirectional(
                    top: BorderSide(color: AppColors.borderGray))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_itemCount > 1) {
                            setState(() => _itemCount--);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.remove,
                            size: 23,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        "$_itemCount",
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 17),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() => _itemCount++);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.add,
                              size: 23,
                              color: AppColors.primaryColor,
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    if (context.read<CartProvider>().getCartSession == null) {
                      showShoppingModal();
                    } else {
                      context.read<ProductProvider>().addToCart(
                          beverage: product,
                          quantity: _itemCount,
                          cartId:
                              context.read<CartProvider>().getCartSession!.id,
                          addedBy: {
                            "email": user!.email!,
                            "name": "${user.firstName} ${user.lastName}",
                            "user_id": user.id.toString()
                          });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.tertiaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          size: 23,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add to Cart",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  void showShoppingModal() {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (BuildContext ctx) {
          return StatefulBuilder(builder: (context, setState) {
            return Consumer<InviteProvider>(
                builder: (context, provider, child) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Select Shopping Cart",
                        style: FontClass.headerStyleMediumBlack),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: provider.getCollabList.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              final shoppingItem =
                                  provider.getCollabList[index];
                              return ListTile(
                                leading: Checkbox(
                                  value: itemValue == shoppingItem.id,
                                  onChanged: (bool? value) {
                                    context
                                        .read<CartProvider>()
                                        .setCartSession(shoppingItem);
                                    setState(() {
                                      itemValue = shoppingItem.id;
                                    });
                                    context.pop();
                                  },
                                ),
                                title: Text("${shoppingItem.name}"),
                              );
                            }))
                  ],
                ),
              );
            });
          });
        });
  }
}
