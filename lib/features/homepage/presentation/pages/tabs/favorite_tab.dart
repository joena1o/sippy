import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:sippy_ca/core/app_colors.dart';
import 'package:sippy_ca/features/widgets/image.dart';
import 'package:sippy_ca/utils/font_class.dart';
import 'package:sippy_ca/utils/utility_class.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Favorites",
                style: FontClass.headerStyleMediumBlack,
              ),
              //const Text("See more")
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
}
