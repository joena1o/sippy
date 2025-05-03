import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sippy_ca/core/app_colors.dart';
import 'package:sippy_ca/features/homepage/data/models/beverage.dart';
import 'package:sippy_ca/features/product/presentation/provider/product_provider.dart';
import 'package:sippy_ca/features/widgets/image.dart';
import 'package:sippy_ca/utils/utility_class.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.cartName, required this.cartId});

  final String cartName;
  final String cartId;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String selectedId = '';

  @override
  void initState() {
    context.read<ProductProvider>().fetchCartItems(widget.cartId, true);
    super.initState();
  }

  void callback() {
    context.read<ProductProvider>().fetchCartItems(widget.cartId, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: Text(
          widget.cartName,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined))
        ],
      ),
      body: Consumer<ProductProvider>(builder: (context, provider, child) {
        final cartItemList = provider.getCartItems;
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  children: List.generate(cartItemList.length, (index) {
                    final cartItem = cartItemList[index];
                    final beverageItem = findBeverage(cartItem.itemId!);
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 200,
                            child: ImageWidget(imageUrl: beverageItem.imageUrl),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(beverageItem.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 20,
                              ),
                              Text("\$ ${beverageItem.price.toString()}",
                                  style: const TextStyle(fontSize: 18)),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  "Added by: ${cartItemList[index].createdBy!.name}",
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.darkColor, width: 1),
                                    ),
                                    child: const Icon(Icons.remove),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text("${cartItemList[index].quantity}"),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 50,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                    ),
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              )
                            ],
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          if (!provider.deletingCartItemStatus &&
                              selectedId != cartItem.documentId)
                            IconButton(
                                onPressed: () {
                                  setState(
                                      () => selectedId = cartItem.documentId);
                                  provider.removeFromCart(
                                      cartItem.documentId, callback);
                                },
                                icon: const Icon(Icons.close)),
                          if (provider.deletingCartItemStatus &&
                              selectedId == cartItem.documentId)
                            const Center(child: CircularProgressIndicator())
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 2, color: AppColors.lightGray))),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("\$ 69.45", style: TextStyle(fontSize: 18))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delivery Fee: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("\$ 5.45", style: TextStyle(fontSize: 18))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("\$ 6.45", style: TextStyle(fontSize: 18))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "\$ 69.45",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              width: 50,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(AppColors.primaryColor),
                    foregroundColor: const WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {
                    context.go("/confirmation-page");
                  },
                  child: const Text(
                    "Checkout",
                    style: TextStyle(fontSize: 21),
                  )),
            )
          ],
        ),
      ),
    );
  }

  BeverageItem findBeverage(String id) {
    return UtilityClass.brandedBeverages
        .firstWhere((item) => item.itemId == id);
  }
}
