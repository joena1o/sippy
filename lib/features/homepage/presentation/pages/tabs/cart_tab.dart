import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sippy_ca/core/app_colors.dart';
import 'package:sippy_ca/features/auth/presentation/provider/auth_provider.dart'
    show AuthProvider;
import 'package:sippy_ca/features/homepage/presentation/provider/invite_provider.dart';
import 'package:sippy_ca/features/widgets/loader.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

enum AnimationStyles { defaultStyle, custom, none }

const List<(AnimationStyles, String)> animationStyleSegments =
    <(AnimationStyles, String)>[
  (AnimationStyles.defaultStyle, 'Default'),
  (AnimationStyles.custom, 'Custom'),
  (AnimationStyles.none, 'None'),
];

class _CartTabState extends State<CartTab> {
  final settings = RestrictedPositions(
    maxCoverage: 0.8,
    minCoverage: -0.5,
    align: StackAlign.left,
  );

  AnimationStyle? _animationStyle;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().currentUserState;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Select Cart",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          Consumer<InviteProvider>(builder: (context, provider, child) {
            return !provider.fetchedCollabList
                ? Expanded(
                    child: ListView.builder(
                    itemCount: provider.getCollabList.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      final collabShop = provider.getCollabList[index];
                      final stackCount = collabShop.accepted!.isEmpty
                          ? 1
                          : collabShop.accepted!.length.toInt() + 1;
                      return GestureDetector(
                        onTap: () {
                          context.push("/cart-page", extra: {
                            "cartName": collabShop.name.toString(),
                            "cartId": collabShop.id
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: AppColors.lightGray))),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(collabShop.name.toString()),
                            trailing: PopupMenuButton<String>(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              popUpAnimationStyle: _animationStyle,
                              icon: const Icon(Icons.more_vert),
                              onSelected: (String item) {
                                if (item == "preview") {
                                  context.push("/cart-page",
                                      extra: collabShop.name.toString());
                                }
                                if (item == 'link') {
                                  Clipboard.setData(ClipboardData(
                                      text:
                                          "https://joenadev.netlify.app/invite/${collabShop.id}"));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Linked copied")),
                                  );
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'preview',
                                  child: ListTile(
                                    leading: Icon(Icons.visibility_outlined),
                                    title: Text('Preview'),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: "link",
                                  child: ListTile(
                                    leading: Icon(Icons.link_outlined),
                                    title: Text('Get link'),
                                  ),
                                ),
                                const PopupMenuDivider(),
                                const PopupMenuItem<String>(
                                  value: "remove",
                                  child: ListTile(
                                    leading: Icon(Icons.delete_outline),
                                    title: Text('Remove'),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Visibility(
                                        visible: collabShop.accepted!.isEmpty,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                  width: 2,
                                                  color: AppColors.lightGray)),
                                          child: const CircleAvatar(
                                            child: Icon(Icons.person),
                                          ),
                                        )),
                                    Visibility(
                                      visible: collabShop.accepted!.isNotEmpty,
                                      child: SizedBox(
                                          height: 40,
                                          width: 60,
                                          child: WidgetStack(
                                            positions: settings,
                                            stackedWidgets: List.generate(
                                                stackCount, (index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: AppColors
                                                            .lightGray)),
                                                child: const CircleAvatar(
                                                  child: Icon(Icons.person),
                                                ),
                                              );
                                            }),
                                            buildInfoWidget: (surplus, ctx) {
                                              return Center(
                                                  child: Text(
                                                '+$surplus',
                                              ));
                                            },
                                          )),
                                    ),
                                    Visibility(
                                      visible: collabShop.accepted!.isNotEmpty,
                                      child: const SizedBox(
                                        width: 10,
                                      ),
                                    ),
                                    Expanded(
                                        child: Text((collabShop
                                                .accepted!.isNotEmpty)
                                            ? "${"${collabShop.accepted!.map((e) => e.toString()).toString().replaceAll("(", "").replaceAll(")", "")},"} you"
                                            : "You")),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Created By: ${collabShop.creatorsName}")
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))
                : const Loader();
          })
        ],
      ),
    );
  }
}
