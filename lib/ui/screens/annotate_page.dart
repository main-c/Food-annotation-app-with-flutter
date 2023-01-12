import 'dart:io';
import 'package:app/models/category.dart';
import 'package:app/models/component.dart';
import 'package:app/services/food_provider.dart';
import 'package:app/ui/screens/annotate_dish_page.dart';
import 'package:app/ui/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:app/image_painter.dart';

class AnnotationPage extends StatefulWidget {
  AnnotationPage({Key? key, required this.currentImage}) : super(key: key);

  File? currentImage;
  @override
  _AnnotationPageState createState() => _AnnotationPageState();
}

class _AnnotationPageState extends State<AnnotationPage> {
  FoodProvider foodProvider = FoodProvider();

  final _imageKey = GlobalKey<ImagePainterState>();
  final _key = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _name = "";
  String _type = "";
  final List<String> _types = ["Main", "Supplement"];
  String? _category;
  List<Food> foods = [];
  bool isActive = false;
  Color currentColor = Colors.green;

  GlobalKey<ImagePainterState> get imageKey => _imageKey;

  final List<Category> _categories = [
    Category(id: 1, name: "Vegetables"),
    Category(id: 2, name: "Fruits"),
    Category(id: 3, name: "Meat"),
    Category(id: 4, name: "Fish"),
    Category(id: 5, name: "Dairy"),
    Category(id: 6, name: "Grains"),
    Category(id: 7, name: "Spices"),
    Category(id: 8, name: "Sauces"),
    Category(id: 9, name: "Others"),
  ];

  void saveImage() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
          backgroundColor: Colors.grey[200],
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
          title: Text("Image Annotation",
              style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: CustomColors.titleColor,
                  ))),
      body: Container(
        color: Colors.grey[200],
        child: ImagePainter.file(
          widget.currentImage!,
          key: _imageKey,
          scalable: true,
          initialStrokeWidth: 2,
          textDelegate: TextDelegate(),
          initialColor: Colors.green,
          initialPaintMode: PaintMode.freeStyle,
          onColorChanged: (value) => {currentColor = value},
          onDrawingEnd: _showRegisterDialog(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isActive ? CustomColors.secondColor : Colors.grey,
        onPressed: isActive
            ? () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => DishAnnotationPage(
                                foods: foods,
                                imagePath: widget.currentImage!.path,
                                imageKey: imageKey,
                              )))
                }
            : null,
        tooltip: 'Next',
        child: const Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }

  AlertDialog _showRegisterDialog() {
    return AlertDialog(
      title: Text(
        "Name the selection",
        style: Theme.of(context).textTheme.headline2?.copyWith(
              color: CustomColors.titleColor,
            ),
      ),
      elevation: 5,
      contentPadding: const EdgeInsets.only(top: 10),
      content: Container(
        height: 285,
        width: 375,
        child: Column(children: [
          Expanded(
            child: Form(
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
                        onChanged: (value) => _name = value,
                        validator: (value) =>
                            value!.isNotEmpty ? null : "Invalid Field",
                        onSaved: (newValue) => _name = newValue!,
                        decoration: InputDecoration(
                            label: Text(
                              "name",
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
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            label: Text(
                              "type",
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
                        items: _types
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
                        value: "Main",
                        hint: Text(
                          'Choose a type of food',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        isExpanded: true,
                        onChanged: (String? value) {
                          if (value is String) {
                            setState(() {
                              _type = value;
                            });
                          }
                        },
                        onSaved: (value) {
                          if (value is String) {
                            setState(() {
                              _type = value;
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
                        height: 12,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            label: Text(
                              "category",
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
                        items: _categories
                            .map((item) => DropdownMenuItem(
                                  value: item.name,
                                  child: Text(
                                    item.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(fontSize: 16),
                                  ),
                                ))
                            .toList(),
                        value: "Meat",
                        hint: Text(
                          'Choose a type of food',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        isExpanded: true,
                        onChanged: (String? value) {
                          if (value is String) {
                            setState(() {
                              _category = value;
                            });
                          }
                        },
                        onSaved: (value) {
                          if (value is String) {
                            setState(() {
                              _category = value;
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
                      )
                    ]),
              ),
            ),
          )
        ]),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () {
            final state = _imageKey.currentState!;
            //remove last
            state.paintHistory = state.paintHistory;
            Navigator.pop(context);
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
            if (_formkey.currentState!.validate()) {
              final state = _imageKey.currentState!;
              _formkey.currentState!.save();
              foods.add(Food(
                  name: _name,
                  type: _type,
                  color: currentColor.value,
                  category: _categories
                      .where((element) => element.name == _category)
                      .first
                      .name,
                  paintInfo: state.paintHistory.last.toString()));
              setState(() {
                isActive = true;
              });
              Navigator.pop(context);
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(CustomColors.mainColor),
          ),
          child: Text(
            "Done",
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
          ),
        )
      ],
    );
  }
}
