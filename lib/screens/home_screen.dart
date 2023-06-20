import 'package:db_shop/widgets/dialogs/create_dialogs/add_category_dialog.dart';
import 'package:flutter/material.dart';
import '../services/firestore_database.dart';
import '../widgets/categories_widget.dart';
import '../widgets/appbars/home_screen_appbar.dart';
import '../widgets/items_widget..dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          const HomeScreenAppBar(),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                //Search Bar
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 300,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 14, 32, 199)),
                                hintText: 'Search here',
                                border: InputBorder.none),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 14, 32, 199),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //Categories
                Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: const Text(
                                'Categories',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 14, 32, 199),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await showAddCategoryDialog(context);
                                },
                                icon: const Icon(Icons.add))
                          ],
                        )),
                    const CategoriesWidget(),
                  ],
                ),

                //Best Selling
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: const Text(
                        'Best Selling',
                        style: TextStyle(
                            color: Color.fromARGB(255, 14, 32, 199),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const ItemsWidget(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
