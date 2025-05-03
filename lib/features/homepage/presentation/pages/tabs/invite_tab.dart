import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sippy_ca/core/app_colors.dart';
import 'package:sippy_ca/features/auth/presentation/provider/auth_provider.dart';
import 'package:sippy_ca/features/homepage/data/models/shopping_invite_model.dart';
import 'package:sippy_ca/features/homepage/presentation/provider/invite_provider.dart';

class InviteTab extends StatefulWidget {
  const InviteTab({super.key});

  @override
  State<InviteTab> createState() => _InviteTabState();
}

class _InviteTabState extends State<InviteTab> {
  String currentId = '';

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().currentUserState;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Notifications",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),
          Consumer<InviteProvider>(builder: (context, provider, child) {
            return Expanded(
                child: SizedBox(
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('collab-shopping')
                    .where("emails", arrayContains: user!.email!)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text("No notifications")],
                    );
                  }

                  final invitationList = snapshot.data!.docs
                      .map((doc) => ShoppingInviteModel.fromJson(
                          doc.data() as Map<String, dynamic>))
                      .toList();

                  return ListView.builder(
                      itemCount: invitationList.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        final invitation = invitationList[index];

                        if (invitation.declined!.contains(user.email)) {
                          return Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: AppColors.borderGray))),
                              child: ListTile(
                                title: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        invitation.name.toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "${invitation.creatorsName} sent you a collaborative shopping invite"),
                                    ],
                                  ),
                                ),
                                subtitle:
                                    const Text("invite has been accepted"),
                              ));
                        }

                        if (invitation.accepted!.contains(user.email)) {
                          return Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: AppColors.borderGray))),
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      invitation.name.toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "${invitation.creatorsName} sent you a collaborative shopping invite"),
                                  ],
                                ),
                                subtitle: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text("invite has been accepted"),
                                ),
                              ));
                        }

                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: AppColors.borderGray))),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  invitation.name.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "${invitation.creatorsName} sent you a collaborative shopping invite"),
                              ],
                            ),
                            subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: provider.loadingRequestStatus &&
                                        currentId == invitation.id
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : Row(
                                        children: [
                                          ElevatedButton(
                                              style: const ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                          Colors.green)),
                                              onPressed: () {
                                                setState(() =>
                                                    currentId = invitation.id);
                                                provider.acceptOrDeclineInvite(
                                                    invitation,
                                                    context
                                                        .read<AuthProvider>()
                                                        .currentUserState!
                                                        .email!,
                                                    true);
                                              },
                                              child: const Text("Accept")),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                              style: const ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                          Colors.red)),
                                              onPressed: () {
                                                setState(() =>
                                                    currentId = invitation.id);
                                                provider.acceptOrDeclineInvite(
                                                    invitation,
                                                    context
                                                        .read<AuthProvider>()
                                                        .currentUserState!
                                                        .email!,
                                                    false);
                                              },
                                              child: const Text("Decline")),
                                        ],
                                      )),
                          ),
                        );
                      });
                },
              ),
            ));
          })
        ],
      ),
    );
  }
}
