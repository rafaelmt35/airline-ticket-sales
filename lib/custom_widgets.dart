import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'const.dart';

Widget containerMusic(BuildContext context, String assetImage, String title,
    String town, String price) {
  return Container(
    margin: const EdgeInsets.only(top: 10.0),
    height: MediaQuery.of(context).size.height / 3.37,
    width: MediaQuery.of(context).size.width / 2.5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 132,
          width: 133,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(image: AssetImage(assetImage))),
        ),
        Text(
          title,
          style: TextStyle(
              color: white,
              fontSize: 16.0,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500),
        ),
        Text(
          town,
          style: TextStyle(
            color: white,
            fontSize: 14.0,
            fontFamily: 'SF Pro Display',
          ),
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/plane.svg',
              width: 24,
              height: 24,
            ),
            Text(
              'от $price ₽',
              style: TextStyle(
                color: white,
                fontSize: 14.0,
                fontFamily: 'SF Pro Display',
              ),
            ),
          ],
        )
      ],
    ),
  );
}

class ActionButtonModal extends StatelessWidget {
  const ActionButtonModal({
    super.key,
    required this.title,
    required this.assets,
    required this.color,
    required this.onTap,
  });
  final String title;
  final String assets;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 120,
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 48.0,
              width: 48.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), color: color),
              child: Center(
                child: SvgPicture.asset(
                  assets,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: white, fontSize: 14.0, fontFamily: 'SF Pro Display'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CityPopularCard extends StatelessWidget {
  const CityPopularCard({
    super.key,
    required this.city,
    required this.onTap,
    required this.imageassets,
  });
  final String city;
  final VoidCallback onTap;
  final String imageassets;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 + 20,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(imageassets))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  city,
                  style: TextStyle(
                      color: white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'SF Pro Display'),
                ),
                Text(
                  'Популярное направление',
                  style: TextStyle(
                      color: grey5,
                      fontSize: 14.0,
                      fontFamily: 'SF Pro Display'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ButtonLongFilter extends StatelessWidget {
  const ButtonLongFilter({
    super.key,
    required this.action,
    required this.onTap,
    required this.icon,
    required this.iconColor,
  });
  final String action;
  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10.0),
        width: 95,
        height: 33,
        decoration: BoxDecoration(
            color: grey3, borderRadius: BorderRadius.circular(50.0)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 18.0,
              ),
              Text(
                action,
                style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'SF Pro Display',
                    fontStyle: FontStyle.italic,
                    color: white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Airlinescontainerview extends StatelessWidget {
  const Airlinescontainerview({
    super.key,
    required this.ticketOffers,
  });

  final List<Map<String, dynamic>> ticketOffers;

  Color getColorFromPriorityIndex(int index) {
    switch (index) {
      case 0:
        return redspecial;
      case 1:
        return blue;
      case 2:
        return white;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ticketOffers.asMap().entries.map((entry) {
        final int index = entry.key;
        final Map<String, dynamic> offer = entry.value;
        final String airlinesname = offer['title'] ?? '';
        final int price = offer['price']['value'] ?? 0;
        final List<String> times = List<String>.from(offer['time_range'] ?? []);

        return Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Container(
                    height: 24,
                    width: 24,
                    margin: const EdgeInsets.only(bottom: 15.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: getColorFromPriorityIndex(index)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 96,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    airlinesname,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'SF Pro Display',
                                      fontStyle: FontStyle.italic,
                                      color: white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '$price ₽ ',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'SF Pro Display',
                                      fontStyle: FontStyle.italic,
                                      color: blue2,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16.0,
                                    color: blue2,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 96,
                          child: Text(
                            times.join('  '),
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'SF Pro Display',
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: grey5,
            ),
          ],
        );
      }).toList(),
    );
  }
}

class LongButton extends StatelessWidget {
  const LongButton({
    super.key,
    required this.action,
    required this.onTap,
    required this.colors,
  });
  final String action;
  final VoidCallback onTap;
  final Color colors;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15.0),
        height: 42.0,
        decoration: BoxDecoration(
            color: colors, borderRadius: BorderRadius.circular(8.0)),
        child: Center(
          child: Text(
            action,
            style: TextStyle(
                color: white,
                fontStyle: FontStyle.italic,
                fontSize: 16.0,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class TicketsContainer extends StatelessWidget {
  const TicketsContainer({
    super.key,
    this.ticket,
  });

  final dynamic ticket;

  @override
  Widget build(BuildContext context) {
    return ticket['badge'] != null
        ? Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            height: 137,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      height: 117,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: grey2,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${ticket['price']['value']} ₽',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'SF Pro Display',
                              color: white,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${ticket['departure']['date'].substring(11, 16)} - ${ticket['arrival']['date'].substring(11, 16)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'SF Pro Display',
                                          color: white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '${(DateTime.parse('2022-01-01 ${ticket['arrival']['date'].substring(11, 16)}:00').difference(DateTime.parse('2022-01-01 ${ticket['departure']['date'].substring(11, 16)}:00')).inSeconds / 3600).toStringAsFixed(1)}ч в пути${ticket['has_transfer'] == false ? '/Без пересадок' : ''}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'SF Pro Display',
                                          color: white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${ticket['departure']['airport']} - ${ticket['arrival']['airport']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'SF Pro Display',
                                      color: grey6,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 8.0,
                  left: 0,
                  child: Container(
                    width: 126,
                    height: 24,
                    decoration: BoxDecoration(
                      color: blue2,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Center(
                      child: Text(
                        ticket['badge'],
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          fontFamily: 'SF Pro Display',
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.all(16.0),
            height: 117,
            margin: const EdgeInsets.only(bottom: 15.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: grey2,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${ticket['price']['value']} ₽',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'SF Pro Display',
                    color: white,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${ticket['departure']['date'].substring(11, 16)} - ${ticket['arrival']['date'].substring(11, 16)}',
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'SF Pro Display',
                                color: white,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '${(DateTime.parse('2022-01-01 ${ticket['arrival']['date'].substring(11, 16)}:00').difference(DateTime.parse('2022-01-01 ${ticket['departure']['date'].substring(11, 16)}:00')).inSeconds / 3600).toStringAsFixed(1)}ч в пути${ticket['has_transfer'] == false ? '/Без пересадок' : ''}',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'SF Pro Display',
                                color: white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${ticket['departure']['airport']} - ${ticket['arrival']['airport']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'SF Pro Display',
                            color: grey6,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
  }
}
