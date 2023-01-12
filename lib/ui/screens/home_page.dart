import 'dart:io';

import 'package:app/services/dish_provider.dart';
import 'package:app/services/food_provider.dart';
import 'package:app/src/_image_painter.dart';
import 'package:app/ui/screens/annotate_page.dart';
import 'package:app/ui/screens/detail_dish_page.dart';
import 'package:app/ui/themes/color.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/component.dart';
import '../../models/dish.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DishProvider dishProvider = DishProvider();
  FoodProvider foodProvider = FoodProvider();

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final currentImage = File(image.path);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AnnotationPage(
                  currentImage: currentImage,
                )),
      );
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  void _openMyPage() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Wrap(children: [
          ListTile(
              leading: const Icon(
                Icons.image_outlined,
                color: CustomColors.secondColor,
              ),
              title: Text(
                'Gallery',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: (() => pickImage(ImageSource.gallery))),
          ListTile(
              leading: const Icon(
                Icons.camera_alt,
                color: CustomColors.secondColor,
              ),
              title: Text(
                'Camera',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () => pickImage(ImageSource.camera)),
        ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Annoted Images",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: CustomColors.titleColor,
                  ))),
      body: FutureBuilder(
        future: dishProvider.getAllDishes(),
        builder: (BuildContext context, AsyncSnapshot<List<Dish>> snapshot) {
          if (snapshot.hasData) {
            final dishes = snapshot.data;
            return GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: dishes!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // foodProvider.getFoodByDish(dishes[index].id!).then((value) {
                    //   dishes[index].foods = value;
                    foodProvider.getAllFoods().then((value) {
                      print("all foods: ${value.length}");

                      dishes[index].foods = value
                          .where(
                              (element) => element.dishId == dishes[index].id)
                          .toList();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  dish: dishes[index],
                                )),
                      );
                    });
                    // });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(File(dishes[index].image)),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  CustomColors.secondColor.withOpacity(0.9),
                                  CustomColors.mainColor.withOpacity(0.0),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              dishes[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.mainColor,
        onPressed: _openMyPage,
        tooltip: 'Add new food',
        child: const Icon(
          Icons.add,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// GridView.extent(
//           maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
//           padding: const EdgeInsets.all(4),
//           mainAxisSpacing: 4,
//           crossAxisSpacing: 4,
//           children: <Widget>[
//             for (var dish in dishes)
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => DetailPage(
//                               dish: dish,
//                             )),
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       image: NetworkImage(dish.image),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         bottom: 0,
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             gradient: LinearGradient(
//                               begin: Alignment.bottomCenter,
//                               end: Alignment.topCenter,
//                               colors: [
//                                 CustomColors.secondColor.withOpacity(0.9),
//                                 CustomColors.mainColor.withOpacity(0.0),
//                               ],
//                             ),
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 20),
//                           child: Text(
//                             dish.name,
//                             style:
//                                 Theme.of(context).textTheme.subtitle1?.copyWith(
//                                       color: Colors.white,
//                                       fontSize: 20,
//                                     ),
//                             softWrap: true,
//                             overflow: TextOverflow.fade,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//           ]), 