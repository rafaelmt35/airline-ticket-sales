// ignore_for_file: file_names, avoid_print

import 'package:effective_mobile_test/api_Calls.dart';
import 'package:effective_mobile_test/const.dart';
import 'package:effective_mobile_test/custom_widgets.dart';
import 'package:effective_mobile_test/selected_City.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerDeparture = TextEditingController();
  TextEditingController controllerArrival = TextEditingController();

  List<Map<String, dynamic>> offers = [];

  @override
  void initState() {
    super.initState();
    initializeFields();
    fetchOffers();
  }

  Future<void> initializeFields() async {
    final String? departure = await getLastEnteredValueFromCache('departure');
    final String? arrival = await getLastEnteredValueFromCache('arrival');
    setState(() {
      controllerDeparture.text = departure ?? 'Москва';
      controllerArrival.text = arrival ?? 'Турция';
    });
  }

  Future<String?> getLastEnteredValueFromCache(String field) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(field);
  }

  Future<void> saveEnteredValueToCache(String field, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(field, value);
  }

  Future<void> fetchOffers() async {
    try {
      final List<Map<String, dynamic>> fetchedOffers =
          await ApiService.fetchOffers();
      setState(() {
        offers = fetchedOffers;
      });
    } catch (e) {
      print('Error fetching offers: $e');
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //MODAL PAGE
  void _showAdditionalInformationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
              padding: const EdgeInsets.all(16.0),
              height: MediaQuery.of(context).size.height - 40,
              width: MediaQuery.of(context).size.width,
              color: grey2,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/rectangle.svg',
                    width: 38,
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: grey3,
                        borderRadius: BorderRadius.circular(16.0)),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5 - 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              margin: const EdgeInsets.only(right: 10.0),
                              child: SvgPicture.asset(
                                'assets/icons/plane2.svg',
                                width: 24,
                                height: 24,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[а-яА-Я]')),
                                ],
                                onChanged: (value) {
                                  saveEnteredValueToCache('departure', value);
                                },
                                style: TextStyle(
                                    color: white,
                                    fontSize: 16.0,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w500),
                                controller: controllerDeparture,
                                decoration: InputDecoration(
                                  hintText: 'Откуда - Москва',
                                  hintStyle: TextStyle(
                                      color: grey6,
                                      fontSize: 16.0,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w500),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: grey5,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              margin: const EdgeInsets.only(right: 10.0),
                              child: SvgPicture.asset(
                                'assets/icons/searchwhite.svg',
                                width: 24,
                                height: 24,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[а-яА-Я]')),
                                ],
                                style: TextStyle(
                                    color: white,
                                    fontSize: 16.0,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w500),
                                controller: controllerArrival,
                                decoration: InputDecoration(
                                  hintText: 'Куда - Турция',
                                  hintStyle: TextStyle(
                                      color: grey6,
                                      fontSize: 16.0,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w500),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    color: white,
                                    onPressed: () {
                                      controllerArrival.clear();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ActionButtonModal(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: 'Сложный маршрут',
                        assets: 'assets/icons/hardmarshut.svg',
                        color: darkgreen2,
                      ),
                      // MIN FUNCTION
                      ActionButtonModal(
                        onTap: () {
                          setState(() {
                            controllerArrival.text = 'Индонезия';
                          });
                        },
                        title: 'Куда угодно',
                        assets: 'assets/icons/globe.svg',
                        color: blue,
                      ),
                      ActionButtonModal(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: 'Выходные',
                        assets: 'assets/icons/calendar.svg',
                        color: const Color(0xff00427D),
                      ),
                      ActionButtonModal(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: 'Горячие билеты',
                        assets: 'assets/icons/hot.svg',
                        color: redspecial,
                      )
                    ],
                  ),
                  Container(
                    height: 216.0,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: grey3,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CityPopularCard(
                          imageassets: 'assets/images/istanbul.png',
                          city: 'Стамбул',
                          onTap: () {},
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: grey5,
                        ),
                        CityPopularCard(
                          imageassets: 'assets/images/sochi.png',
                          city: 'Сочи',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectedCityPage(
                                        cityArrival: 'Сочи',
                                        controllerDeparture:
                                            controllerDeparture)));
                          },
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: grey5,
                        ),
                        CityPopularCard(
                          imageassets: 'assets/images/pukhet.png',
                          city: 'Пхукет',
                          onTap: () {},
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: grey5,
                        ),
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/planebotnav.svg',
              width: 24,
              height: 24,
            ),
            label: 'Авиабилеты',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bed),
            label: 'Отели',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop_sharp),
            label: 'Короче',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Подписки',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: blue,
        unselectedItemColor: grey6,
        backgroundColor: black,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(color: blue),
        selectedLabelStyle: const TextStyle(
            fontSize: 12.0,
            fontFamily: 'SF Pro Display'), // Style for selected label
        unselectedLabelStyle: const TextStyle(
            fontSize: 12.0,
            fontFamily: 'SF Pro Display'), // Style for unselected label
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Поиск дешевых \nавиабилетов',
                    style: TextStyle(
                        color: white,
                        fontSize: 22,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25.0, bottom: 26.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: BoxDecoration(
                      color: grey3, borderRadius: BorderRadius.circular(16.0)),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      width: MediaQuery.of(context).size.width - 42,
                      height: MediaQuery.of(context).size.height / 5 - 32,
                      decoration: BoxDecoration(
                          color: grey4,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: SvgPicture.asset(
                              'assets/icons/searchicon.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 113,
                            height: MediaQuery.of(context).size.height / 5 - 65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[а-яА-Я]')),
                                    ],
                                    onChanged: (value) {
                                      saveEnteredValueToCache(
                                          'departure', value);
                                    },
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 16.0,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w500),
                                    controller: controllerDeparture,
                                    decoration: InputDecoration(
                                      hintText: 'Откуда - Москва',
                                      hintStyle: TextStyle(
                                          color: grey6,
                                          fontSize: 16.0,
                                          fontFamily: 'SF Pro Display',
                                          fontWeight: FontWeight.w500),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: grey5,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      _showAdditionalInformationModal(context);
                                    },
                                    child: Expanded(
                                        child: Container(
                                      margin: const EdgeInsets.only(top: 10.0),
                                      height: 30,
                                      child: Text(
                                        'Куда - Турция',
                                        style: TextStyle(
                                            color: grey6,
                                            fontSize: 16.0,
                                            fontFamily: 'SF Pro Display',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  'Музыкально отлететь',
                  style: TextStyle(
                      color: white,
                      fontSize: 22,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.27,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: offers.length,
                    itemBuilder: (context, index) {
                      final offer = offers[index];
                      return containerMusic(
                        context,
                        'assets/images/offer${offer['id']}.png',
                        offer['title'],
                        offer['town'],
                        offer['price']['value'].toString(),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
