import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_news_api/src/ui/utils/router.dart';
import 'package:app_news_api/src/ui/widgets/circular_icon.dart';
import 'package:app_news_api/src/ui/views/search/search_view.dart';

import '../home_provider.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  HomeAppBar({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = context.read<HomeProvider>();
    final TextEditingController searchCtrl = homeProvider.searchCtrl;

    return AppBar(
      leadingWidth: 0,
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 10,
            child: Consumer<HomeProvider>(builder: (_, provider, __) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: provider.isSearching
                    ? Form(
                        key: _formKey,
                        child: CupertinoTextFormFieldRow(
                          controller: homeProvider.searchCtrl,
                          placeholder: 'Buscar...',
                          validator: (query) =>
                              query != null && query.isNotEmpty
                                  ? null
                                  : 'Escribe por lo menos un caracter',
                          onEditingComplete: () {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              MyRouter.goTo(
                                context,
                                SearchView(query: searchCtrl.text.trim()),
                              );
                            }
                          },
                        ),
                      )
                    : const Text('News - Api'),
              );
            }),
          ),
          Expanded(
            flex: 2,
            child: Consumer<HomeProvider>(builder: (_, provider, __) {
              final bool isSearching = provider.isSearching;
              return CircularIcon(
                  icon: isSearching ? Icons.close : Icons.search,
                  onTap: () {
                    if (isSearching) {
                      if (searchCtrl.text.isNotEmpty) {
                        provider.searchCtrl.clear();
                      } else {
                        FocusScope.of(context).requestFocus(FocusNode());
                        homeProvider.toggleSearching();
                      }
                    } else {
                      homeProvider.toggleSearching();
                    }
                  });
            }),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
