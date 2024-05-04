// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Map<String, dynamic>>> fetchOffers() async {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/00727197-24ae-48a0-bcb3-63eb35d7a9de'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<Map<String, dynamic>> offers =
          List<Map<String, dynamic>>.from(data['offers']);
      return offers;
    } else {
      throw Exception('Failed to load offers');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchGetTicketsOffer() async {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/3424132d-a51a-4613-b6c9-42b2d214f35f'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<Map<String, dynamic>> offers =
          List<Map<String, dynamic>>.from(data['tickets_offers']);
      return offers;
    } else {
      throw Exception('Failed to load tickets offers');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchGetAllTickets() async {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/2dbc0999-86bf-4c08-8671-bac4b7a5f7eb'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<Map<String, dynamic>> offers =
          List<Map<String, dynamic>>.from(data['tickets']);
      return offers;
    } else {
      throw Exception('Failed to load tickets');
    }
  }
}
