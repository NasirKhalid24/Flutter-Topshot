import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:topshot_scan/modules/searchbar/searchbar_controller.dart';
import 'package:topshot_scan/theme/color_theme.dart';

Widget buildFloatingSearchBar() {
  final SearchBarController controller = Get.find<SearchBarController>();

  return FloatingSearchBar(
    hint: 'Search...',
    backgroundColor: Colors.black,
    backdropColor: Colors.black54,
    border: BorderSide(color: MainColors.purple),
    hintStyle: TextStyle(color: Colors.white, fontFamily: "Lexend"),
    borderRadius: BorderRadius.circular(30),
    progress: controller.searching.isTrue,
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 600),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    debounceDelay: const Duration(milliseconds: 500),
    onQueryChanged: (query) {
      // Call your model, bloc, controller here.
      controller.fetchQuery(query);
    },
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    transition: CircularFloatingSearchBarTransition(),
    actions: [
      // FloatingSearchBarAction.hamburgerToBack(isLeading: false),
      FloatingSearchBarAction(
          showIfOpened: true,
          showIfClosed: false,
          builder: (context, animation) {
            final bar = FloatingSearchAppBar.of(context)!;

            return ValueListenableBuilder<String>(
              valueListenable: bar.queryNotifer,
              builder: (context, query, _) {
                final isEmpty = query.isEmpty;

                return SearchToClear(
                  isEmpty: isEmpty,
                  color: Colors.white,
                  duration: Duration(milliseconds: 250),
                  onTap: () {
                    if (!isEmpty) {
                      bar.clear();
                      bar.close();
                    } else {
                      bar.isOpen =
                          !bar.isOpen || (!bar.hasFocus && bar.isAlwaysOpened);
                    }
                  },
                );
              },
            );
          })
    ],
    builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Obx(() {
              // ignore: unrelated_type_equality_checks
              if (controller.searching == true) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LinearProgressIndicator(),
                    ...controller.headers.cast()
                  ],
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: controller.headers.cast(),
                );
              }
            })),
      );
    },
  );
}
