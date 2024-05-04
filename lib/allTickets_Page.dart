// ignore_for_file: file_names, avoid_print

import 'package:effective_mobile_test/api_Calls.dart';
import 'package:effective_mobile_test/const.dart';
import 'package:effective_mobile_test/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllTicketsPage extends StatefulWidget {
  const AllTicketsPage({
    super.key,
    required this.departuredate,
    required this.arrivaldate,
    required this.departurecity,
    required this.arrivalcity,
  });

  final String departuredate;
  final String arrivaldate;
  final String departurecity;
  final String arrivalcity;

  @override
  State<AllTicketsPage> createState() => _AllTicketsPageState();
}

class _AllTicketsPageState extends State<AllTicketsPage> {
  List<Map<String, dynamic>> tickets = [];

  @override
  void initState() {
    fetchedTickets();
    super.initState();
  }

  Future<void> fetchedTickets() async {
    try {
      final List<Map<String, dynamic>> fetchedTickets =
          await ApiService.fetchGetAllTickets();
      setState(() {
        tickets = fetchedTickets;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    height: 56.0,
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
                            Icons.arrow_back,
                            color: Colors.blue,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.departurecity}-${widget.arrivalcity}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            widget.arrivaldate != '+ обратно'
                                ? Text(
                                    '${widget.departuredate} - ${widget.arrivaldate}, 1 пассажир',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14.0,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'SF Pro Display',
                                    ),
                                  )
                                : Text(
                                    '${widget.departuredate}, 1 пассажир',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14.0,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'SF Pro Display',
                                    ),
                                  )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: tickets.length,
                      itemBuilder: (BuildContext context, int index) {
                        final ticket = tickets[index];
                        return TicketsContainer(ticket: ticket);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 25.0),
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                height: 37,
                width: 203,
                decoration: BoxDecoration(
                  color: blue2,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.tune,
                            color: white,
                          ),
                          Text(
                            'Фильтр',
                            style: TextStyle(
                                color: white,
                                fontSize: 14.0,
                                fontFamily: 'SF Pro Display'),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.bar_chart,
                            color: white,
                          ),
                          Text(
                            'График цен',
                            style: TextStyle(
                                color: white,
                                fontSize: 14.0,
                                fontFamily: 'SF Pro Display'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: const IconThemeData(color: Colors.blue),
        selectedLabelStyle:
            const TextStyle(fontSize: 12.0, fontFamily: 'SF Pro Display'),
        unselectedLabelStyle:
            const TextStyle(fontSize: 12.0, fontFamily: 'SF Pro Display'),
      ),
    );
  }
}
