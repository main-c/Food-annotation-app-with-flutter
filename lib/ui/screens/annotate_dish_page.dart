import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:app/controller/food.dart';
import 'package:app/models/component.dart';
import 'package:app/models/dish.dart';
import 'package:app/services/dish_provider.dart';
import 'package:app/services/food_provider.dart';
import 'package:app/services/save_local.dart';
import 'package:app/ui/screens/home_page.dart';
import 'package:app/ui/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../image_painter.dart';

class DishAnnotationPage extends StatefulWidget {
  DishAnnotationPage(
      {super.key, required this.foods, this.imagePath, required this.imageKey});

  List<Food> foods;
  String? imagePath;
  GlobalKey<ImagePainterState> imageKey;

  @override
  State<DishAnnotationPage> createState() => _DishAnnotationPageState();
}

class _DishAnnotationPageState extends State<DishAnnotationPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _name = "";
  String _country = "";
  final List<String> countries = ["Ethiopia", "South Africa"];
  String _description = "";
  DishProvider dishProvider = DishProvider();
  FoodProvider foodProvider = FoodProvider();
  late int dishId;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Name the dish",
              style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: CustomColors.titleColor,
                  )),
        ),
        body: ListView(
          children: [
            Form(
              key: _formkey,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(fontSize: 16),
                          decoration: InputDecoration(
                              label: Text(
                                "Name",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(fontSize: 16),
                              ),
                              border: const OutlineInputBorder(),
                              focusColor: Colors.grey,
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CustomColors.secondColor,
                                      width: 2))),
                          onChanged: (value) => _name = value,
                          onSaved: (newValue) => _name = newValue!,
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Invalid Field",
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              ?.copyWith(fontSize: 16),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              label: Text(
                                "Description",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(fontSize: 16),
                              ),
                              border: const OutlineInputBorder(),
                              focusColor: Colors.grey,
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CustomColors.secondColor,
                                      width: 2))),
                          onChanged: (value) => _description = value,
                          onSaved: (newValue) => _description = newValue!,
                          validator: (value) =>
                              value!.isNotEmpty ? null : "Invalid Field",
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              label: Text(
                                "Country",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(fontSize: 16),
                              ),
                              border: const OutlineInputBorder(),
                              focusColor: Colors.grey,
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CustomColors.secondColor,
                                      width: 2))),
                          iconEnabledColor: CustomColors.secondColor,
                          items: countries
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(fontSize: 16),
                                    ),
                                  ))
                              .toList(),
                          value: "Ethiopia",
                          hint: Text(
                            'Choose dish country',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          isExpanded: true,
                          onChanged: (String? value) {
                            if (value is String) {
                              setState(() {
                                _country = value;
                              });
                            }
                          },
                          onSaved: (value) {
                            if (value is String) {
                              setState(() {
                                _country = value;
                              });
                            }
                          },
                          validator: (String? value) {
                            if (value is! String) {
                              return "Can't empty";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ])),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    //   if (_formkey.currentState!.validate()) {
                    //     Navigator.pop(context);
                    //   }
                    //   _formkey.currentState!.save();
                    //   dishes.add(Dish(
                    //       name: _name,
                    //       description: _description,
                    //       image: widget.imagePath!,
                    //       country: _country,
                    //       foods: widget.foods));

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage(
                                  title: "Home",
                                )));
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: CustomColors.secondColor,
                          fontSize: 16,
                        ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    isLoading ? null : submitForm();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(CustomColors.mainColor),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator.adaptive(
                          value: 25,
                          backgroundColor: Colors.white,
                        )
                      : Text(
                          "Save and export",
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                        ),
                )
              ],
            )
          ],
        ));
  }

  Future<String> saveImage(String name) async {
    final image = await widget.imageKey.currentState!.exportImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath =
        '$directory/sample/$name-${DateTime.now().millisecondsSinceEpoch}.png';
    final imgFile = File('$fullPath');
    imgFile.writeAsBytesSync(image!);
    return fullPath;
  }

  void submitForm() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      setState(() {
        isLoading = true;
      });

      try {
        saveImage(_name).then((value) {
          Dish dish = Dish(
              name: _name,
              description: _description,
              image: value,
              country: _country,
              foods: widget.foods);

          // save dish in local database and all their foods
          dishProvider.insertDish(dish).then((value) {
            dishId = value;
            for (Food food in widget.foods) {
              food.dishId = dishId;
              foodProvider.insertFood(food);
              print(food.toString());
            }

            setState(() {
              isLoading = false;
            });
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: "Home",
                        )));
          }).catchError((onError) => print(onError));

          Storage storage = Storage(fileName: dish.name, data: dish.toString());
          storage.write();
        }).catchError((onError) => print(onError));
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
