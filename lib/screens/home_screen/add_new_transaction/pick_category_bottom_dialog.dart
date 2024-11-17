import 'package:cash_book_expense_tracker/utils/themes_data.dart';
import 'package:cash_book_expense_tracker/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

import '../../../provider/category_data_provider.dart';

OpenModalBottomSheet2(
  BuildContext context,
) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    elevation: 0,
    context: context,
    builder: (context) => const MyPickCategory(),
  );
}

class MyPickCategory extends StatefulWidget {
  const MyPickCategory({super.key});

  @override
  State<MyPickCategory> createState() => _MyPickCategoryState();
}

class _MyPickCategoryState extends State<MyPickCategory> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final categoriesProvider =
        Provider.of<CategoryDataProvider>(context, listen: false);
    return Container(
      color: Colors.transparent,
      height: screenHeight * 0.44,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTitle(title: "Pick A Category"),
              const SizedBox(
                height: 15,
              ),
              Wrap(
                children: [
                  for (int i = 0;
                      i < categoriesProvider.allCategories.length;
                      i++)
                    Bounceable(
                      onTap: () {
                        setState(() {
                          categoriesProvider.SetPickCategory(i);
                        });
                      },
                      child: Container(
                        width: 65,
                        height: 70,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width:
                                    categoriesProvider.selectedPickCategory == i
                                        ? 2
                                        : 1,
                                color:
                                    categoriesProvider.selectedPickCategory == i
                                        ? selectDark
                                        : Colors.transparent)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              categoriesProvider.allCategories[i].icon,
                              color: iconColor,
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(horizontal: 1),
                                child: FittedBox(
                                    child: Text(
                                  categoriesProvider.allCategories[i].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: iconColor),
                                )))
                          ],
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
