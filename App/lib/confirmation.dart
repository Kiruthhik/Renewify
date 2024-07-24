import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfirmationPage extends StatelessWidget {
  final String name;
  final String phone;
  final String city;
  final String problem;

  ConfirmationPage(this.name, this.phone, this.city, this.problem);

  Future<void> _launchCaller(BuildContext context, String phoneNumber) async {
    final Uri _phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunch(_phoneLaunchUri.toString())) {
        await launch(_phoneLaunchUri.toString());
      } else {
        throw 'Could not launch $_phoneLaunchUri';
      }
    } catch (e) {
      print('Error launching phone call: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content:
              Text('Failed to initiate phone call. Please try again later.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Confirmation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              Text(
                'Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Name: $name', style: TextStyle(fontSize: 15)),
              Text('Phone: $phone', style: TextStyle(fontSize: 15)),
              Text('City: $city', style: TextStyle(fontSize: 15)),
              SizedBox(height: 20),
              Text(
                'Problem Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(problem, style: TextStyle(fontSize: 15)),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _launchCaller(context, phone),
                icon: Icon(Icons.call),
                label: Text('Call Customer Support'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to ComplaintPage
                },
                child: Text('File Another Complaint'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
