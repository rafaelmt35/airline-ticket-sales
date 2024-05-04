// ignore_for_file: must_be_immutable, avoid_print, file_names

import 'package:effective_mobile_test/allTickets_Page.dart';
import 'package:effective_mobile_test/api_Calls.dart';
import 'package:effective_mobile_test/const.dart';
import 'package:effective_mobile_test/custom_widgets.dart';
import 'package:effective_mobile_test/filter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SelectedCityPage extends StatefulWidget {
  SelectedCityPage(
      {super.key,
      required this.controllerDeparture,
      required this.cityArrival});
  TextEditingController controllerDeparture;
  final String cityArrival;
  @override
  State<SelectedCityPage> createState() => _SelectedCityPageState();
}

class _SelectedCityPageState extends State<SelectedCityPage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> ticketoffers = [];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    controllerArrival.text = widget.cityArrival;
    fetchedTicketsOffers();
    super.initState();
  }

  Future<DateTime?> _selectDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      return picked;
    }
    return null;
  }

  Future<void> fetchedTicketsOffers() async {
    try {
      final List<Map<String, dynamic>> fetchedTicketsOffers =
          await ApiService.fetchGetTicketsOffer();
      setState(() {
        ticketoffers = fetchedTicketsOffers;
      });
    } catch (e) {
      print('Error fetching offers: $e');
    }
  }

  String departureDate = '24 фев,сб';
  String arrivalDate = '+ обратно';
  String departDateModified = '24 февраля';
  String arrivalDateModified = '+ обратно';
  bool isReminder = false;
  TextEditingController controllerArrival = TextEditingController();
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
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30.0, bottom: 15.0),
                    padding: const EdgeInsets.all(16.0),
                    width: MediaQuery.of(context).size.width - 42,
                    height: MediaQuery.of(context).size.height / 5 - 32,
                    decoration: BoxDecoration(
                        color: grey4,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.arrow_back,
                              color: white,
                            ),
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
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 16.0,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w500),
                                  controller: widget.controllerDeparture,
                                  decoration: InputDecoration(
                                    hintText: 'Откуда - Москва',
                                    hintStyle: TextStyle(
                                        color: grey6,
                                        fontSize: 16.0,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w500),
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.swap_vert),
                                      color: white,
                                      onPressed: () {
                                        setState(() {
                                          String temp =
                                              widget.controllerDeparture.text;
                                          widget.controllerDeparture.text =
                                              controllerArrival.text;
                                          controllerArrival.text = temp;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: grey5,
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
                                    hintText: 'Откуда - Москва',
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
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15.0),
                    height: 35.0,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            DateTime? selectedDate = await _selectDate(context);
                            String formattedDate = DateFormat('dd MMM, E', 'ru')
                                .format(selectedDate!);
                            String formattedDate1 = DateFormat('dd MMMM', 'ru')
                                .format(selectedDate);

                            setState(() {
                              arrivalDate = formattedDate;
                              arrivalDateModified = formattedDate1;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            width: 88,
                            height: 33,
                            decoration: BoxDecoration(
                                color: grey3,
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Center(
                                child: Text(
                              arrivalDate,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'SF Pro Display',
                                  fontStyle: FontStyle.italic,
                                  color: white),
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? selectedDate = await _selectDate(context);
                            String formattedDate = DateFormat('dd MMM, E', 'ru')
                                .format(selectedDate!);
                            String formattedDate1 = DateFormat('dd MMMM', 'ru')
                                .format(selectedDate);

                            setState(() {
                              departureDate = formattedDate;
                              departDateModified = formattedDate1;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            width: 78,
                            height: 33,
                            decoration: BoxDecoration(
                                color: grey3,
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Center(
                                child: Text(
                              departureDate,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'SF Pro Display',
                                  fontStyle: FontStyle.italic,
                                  color: white),
                            )),
                          ),
                        ),
                        ButtonLongFilter(
                          iconColor: grey5,
                          action: '1,эконом',
                          onTap: () {},
                          icon: Icons.person,
                        ),
                        ButtonLongFilter(
                          iconColor: white,
                          action: 'фильтры',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const FilterPage())));
                          },
                          icon: Icons.tune,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2 - 80,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: grey1,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Прямые рельсы',
                          style: TextStyle(
                              color: white,
                              fontSize: 20.0,
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w500),
                        ),
                        Airlinescontainerview(
                          ticketOffers: ticketoffers,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              'Показать все',
                              style: TextStyle(
                                  color: blue2,
                                  fontSize: 16.0,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  LongButton(
                    colors: blue2,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => AllTicketsPage(
                                    departurecity:
                                        widget.controllerDeparture.text,
                                    arrivalcity: controllerArrival.text,
                                    arrivaldate: arrivalDateModified,
                                    departuredate: departDateModified,
                                  ))));
                    },
                    action: 'Посмотреть все билеты',
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(bottom: 15.0),
                    height: 45.0,
                    decoration: BoxDecoration(
                        color: grey2, borderRadius: BorderRadius.circular(8.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 165.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.notifications,
                                color: blue,
                              ),
                              Text(
                                'Подписка на цену',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'SF Pro Display',
                                    color: white),
                              )
                            ],
                          ),
                        ),
                        Switch(
                          hoverColor: Colors.white,
                          value: isReminder,
                          activeColor: blue2,
                          onChanged: (value) {
                            setState(() {
                              isReminder = value;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
