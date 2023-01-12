import 'dart:io';

import 'package:app/models/dish.dart';
import 'package:app/ui/screens/image_page.dart';
import 'package:flutter/material.dart';

import '../themes/color.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.dish});

  Dish dish;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 25,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(children: [
                GestureDetector(
                  onDoubleTap: (() {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            ImageView(image: File(dish.image)),
                      ),
                    );
                  }),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(dish.image)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 300,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            dish.name,
                            style:
                                Theme.of(context).textTheme.headline1?.copyWith(
                                      color: CustomColors.titleColor,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Wrap(
                                  spacing: 3,
                                  runSpacing: 4,
                                  children: [
                                    for (var food in dish.foods!)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color(food.color).withOpacity(1),
                                        ),
                                        child: Text(
                                          food.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Text(
                                dish.country,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      color: CustomColors.titleColor,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Description',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(color: CustomColors.titleColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            dish.description,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: Color.fromARGB(255, 37, 37, 37),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
        ));
  }
}
