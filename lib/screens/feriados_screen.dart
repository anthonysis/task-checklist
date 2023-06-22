import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeriadosScreen extends StatefulWidget {
  @override
  _FeriadosScreenState createState() => _FeriadosScreenState();
}

class _FeriadosScreenState extends State<FeriadosScreen> {
  List<dynamic> holidays = [];

  @override
  void initState() {
    super.initState();
    fetchHolidays();
  }

  Future<void> fetchHolidays() async {
    final country = 'BR';
    final year = 2023;
    final apiKey = 'ce7289a6441e95659a47d021ebe460ad80b35f84';
    final response = await http.get(
      Uri.parse('https://calendarific.com/api/v2/holidays?api_key=$apiKey&country=$country&year=$year'),
    );

    if (response.statusCode == 200) {

      final data = json.decode(response.body);
      setState(() {
        holidays = data['response']['holidays'];
      });
    } else {

      print('Erro ao buscar feriados: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Feriados'),
      // ),
      body: ListView.builder(
        itemCount: holidays.length,
        itemBuilder: (context, index) {
          final holiday = holidays[index];
          return ListTile(
            title: Text(holiday['name']),
            subtitle: Text(holiday['date']['iso']),
          );
        },
      ),
    );
  }
}
