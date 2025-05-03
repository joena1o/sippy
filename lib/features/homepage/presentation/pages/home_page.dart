import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sippy_ca/core/app_colors.dart';
import 'package:sippy_ca/features/auth/presentation/provider/auth_provider.dart';
import 'package:sippy_ca/features/cart_page.dart/presentation/provider/cart_provider.dart';
import 'package:sippy_ca/features/homepage/presentation/pages/tabs/cart_tab.dart';
import 'package:sippy_ca/features/homepage/presentation/pages/tabs/favorite_tab.dart';
import 'package:sippy_ca/features/homepage/presentation/pages/tabs/home_tab.dart';
import 'package:sippy_ca/features/homepage/presentation/pages/tabs/invite_tab.dart';
import 'package:sippy_ca/features/homepage/presentation/provider/invite_provider.dart';
import 'package:sippy_ca/features/widgets/loader.dart';
import 'package:sippy_ca/utils/font_class.dart';
import 'package:simple_textfield_tag/simple_textfield_tag.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.invite = false});

  final bool? invite;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  List<String> emailTags = [];

  String itemValue = '';

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.invite == true) {
      tabIndex = 2;
    }
    context.read<InviteProvider>().fetchCollabs(
        context.read<AuthProvider>().currentUserState!.email!,
        () => showShoppingModal(),
        tabIndex == 2 ? () {} : () => showCollaborativeModal());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().currentUserState;
    return Scaffold(
      drawer: Drawer(
        shape: const BeveledRectangleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                child: GestureDetector(
                  onTap: () {
                    context.read<CartProvider>().setCartSession(null);
                    context.go("/login");
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 23,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Sign out",
                        style: TextStyle(fontSize: 23),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 69,
        scrolledUnderElevation: 0,
        title: SvgPicture.asset(
          "assets/sippy_logo.svg",
          semanticsLabel: 'Sippy Life',
          width: 55,
        ),
        actions: [
          CircleAvatar(
            backgroundColor: AppColors.darkerPrimary,
            foregroundColor: Colors.purple[100],
            radius: 20,
            child: const Icon(Icons.person),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: IndexedStack(
        index: tabIndex,
        children: const [HomeTab(), FavoriteTab(), InviteTab(), CartTab()],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.borderGray))),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () => setState(() {
                        tabIndex = 0;
                      }),
                  child: Column(
                    children: [
                      Icon(Icons.home,
                          color:
                              tabIndex == 0 ? AppColors.tertiaryColor : null),
                      Text(
                        "Home",
                        style: TextStyle(
                            color:
                                tabIndex == 0 ? AppColors.tertiaryColor : null),
                      )
                    ],
                  )),
              GestureDetector(
                  onTap: () => setState(() {
                        tabIndex = 1;
                      }),
                  child: Column(
                    children: [
                      Icon(Icons.favorite,
                          color:
                              tabIndex == 1 ? AppColors.tertiaryColor : null),
                      Text(
                        "Favorite",
                        style: TextStyle(
                            color:
                                tabIndex == 1 ? AppColors.tertiaryColor : null),
                      )
                    ],
                  )),
              GestureDetector(
                onTap: () => setState(() {
                  tabIndex = 2;
                }),
                child: Column(
                  children: [
                    Icon(Icons.notifications,
                        color: tabIndex == 2 ? AppColors.tertiaryColor : null),
                    Text(
                      "Notification",
                      style: TextStyle(
                          color:
                              tabIndex == 2 ? AppColors.tertiaryColor : null),
                    )
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () => setState(() {
                        tabIndex = 3;
                        context.read<InviteProvider>().fetchCollabs(
                            user!.email!,
                            () {},
                            () => showCollaborativeModal());
                      }),
                  child: Column(
                    children: [
                      Icon(Icons.shopping_cart,
                          color:
                              tabIndex == 3 ? AppColors.tertiaryColor : null),
                      Text(
                        "Cart",
                        style: TextStyle(
                            color:
                                tabIndex == 3 ? AppColors.tertiaryColor : null),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: tabIndex == 0
          ? FloatingActionButton(
              backgroundColor: AppColors.darkerPrimary,
              foregroundColor: Colors.purple[100],
              onPressed: () {
                showCollaborativeModal();
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void showCollaborativeModal() {
    showModalBottomSheet(
        showDragHandle: true,
        isDismissible: false,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext ctx) {
          return StatefulBuilder(builder: (context, setState) {
            return SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Consumer<InviteProvider>(
                    builder: (context, provider, child) {
                  return Form(
                    key: _formkey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text("Create Collaborative Shopping",
                              style: FontClass.headerStyleMediumBlack),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextFormField(
                              controller: provider.nameController,
                              validator: (String? text) {
                                if (text!.isEmpty) {
                                  return "Please enter name of shopping event";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText:
                                    "Enter session name e.g Kelly's Party",
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: SimpleTextFieldTag(
                                labelText: "Invite via email (optional)",
                                initialTags: emailTags,
                                onTagAdded: (tag) {
                                  setState(() {
                                    emailTags = [...emailTags, tag];
                                  });
                                },
                                onTagRemoved: (tag) {
                                  setState(() {
                                    emailTags.remove(tag);
                                  });
                                },
                                chipBackgroundColor:
                                    Theme.of(context).hoverColor,
                                tagTextStyle: const TextStyle(fontSize: 16),
                                labelStyle: const TextStyle(fontSize: 16),
                                hintStyle: const TextStyle(fontSize: 16),
                                hintText: "Enter email",
                                deleteIconColor: Colors.red,
                                chipBorderSide:
                                    BorderSide(color: AppColors.primaryColor),
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          !provider.getLoadingStatus
                              ? ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          AppColors.primaryColor),
                                      foregroundColor: WidgetStatePropertyAll(
                                          AppColors.lightColor)),
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      provider.createInvite(
                                          context
                                              .read<AuthProvider>()
                                              .currentUserState!,
                                          provider.nameController.text,
                                          emailTags, () {
                                        context.pop();
                                        setState(() => emailTags = []);
                                      });
                                    }
                                  },
                                  child: const Text("Create Session"))
                              : const Loader(),
                          const SizedBox(
                            height: 50,
                          )
                        ]),
                  );
                }),
              ),
            );
          });
        });
  }

  void showShoppingModal() {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isDismissible: false,
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
