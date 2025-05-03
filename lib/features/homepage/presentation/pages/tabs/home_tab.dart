import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sippy_ca/core/app_colors.dart';
import 'package:sippy_ca/features/cart_page.dart/presentation/provider/cart_provider.dart';
import 'package:sippy_ca/features/homepage/presentation/provider/invite_provider.dart';
import 'package:sippy_ca/features/widgets/image.dart';
import 'package:sippy_ca/utils/font_class.dart';
import 'package:sippy_ca/utils/utility_class.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String itemValue = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<CartProvider>().getCartSession;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                showShoppingModal();
              },
              child: Row(
                children: [
                  Visibility(
                    visible: session != null,
                    child: Text(
                      "Session: ${session == null ? "" : session.name}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SearchBar(
            elevation: const WidgetStatePropertyAll(0),
            hintText: "Search Item here...",
            trailing: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "New Arrivals",
                style: FontClass.headerStyleMediumBlack,
              ),
              const Text("See more")
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 20,
              children: List.generate(UtilityClass.images.length, (index) {
                final image = UtilityClass.images;
                return GestureDetector(
                  onTap: () {
                    context.push("/product",
                        extra: UtilityClass.brandedBeverages[index]);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: index % 2 == 0 ? 200 : 230,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: ImageWidget(imageUrl: image[index]))),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        UtilityClass.brandedBeverages[index].name,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "\$ ${UtilityClass.brandedBeverages[index].price.toString()}",
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.tertiaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              }),
            ),
          )),
        ],
      ),
    );
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
                width: double.infinity,
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
                    !provider.fetchedCollabList
                        ? Expanded(
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
                        : Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const CircularProgressIndicator(),
                          )
                  ],
                ),
              );
            });
          });
        });
  }
}
