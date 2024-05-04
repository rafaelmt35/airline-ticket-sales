import 'package:effective_mobile_test/const.dart';
import 'package:effective_mobile_test/custom_widgets.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool isNotTransit = true;
  bool isWithBaggage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 15.0),
                height: 42.0,
                decoration: BoxDecoration(
                  color: grey2,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Фильтры',
                      style: TextStyle(
                        color: white,
                        fontSize: 16.0,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Пересадки',
                      style: TextStyle(
                        color: white,
                        fontSize: 16.0,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      height: 141.0,
                      decoration: BoxDecoration(
                        color: grey2,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Без пересадок',
                            style: TextStyle(
                              color: white,
                              fontSize: 16.0,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                          Switch(
                            hoverColor: Colors.white,
                            value: isNotTransit,
                            activeColor: blue,
                            onChanged: (value) {
                              setState(() {
                                isNotTransit = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      height: 51.0,
                      decoration: BoxDecoration(
                        color: grey2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Только с багажом',
                            style: TextStyle(
                              color: white,
                              fontSize: 16.0,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                          Switch(
                            hoverColor: Colors.white,
                            value: isWithBaggage,
                            activeColor: blue,
                            onChanged: (value) {
                              setState(() {
                                isWithBaggage = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LongButton(
          action: 'Готово',
          onTap: () {
            Navigator.pop(context);
          },
          colors: darkgreen2,
        ),
      ),
    );
  }
}
