
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeadListPage extends StatefulWidget {
  const LeadListPage({super.key});

  @override
  _LeadListPageState createState() => _LeadListPageState();
}

class _LeadListPageState extends State<LeadListPage> {
  List<dynamic> _leads = [];

  @override
  void initState() {
    super.initState();
    _fetchLeads();
  }

  Future<void> _fetchLeads() async {
    final response = await http.get(
      Uri.parse('https://crm-beta-api.vozlead.in/api/v2/lead/lead_list/'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _leads = json.decode(response.body);
      });
    } else {
     
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to fetch leads'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lead List'),
      ),
      body: ListView.builder(
        itemCount: _leads.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_leads[index]['name']),
            subtitle: Text(_leads[index]['email']),
           
          );
        },
      ),
    );
  }
}
