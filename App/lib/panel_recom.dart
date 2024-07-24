import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dashboard.dart';
import 'things_to_know.dart';

class PanelRecommendation extends StatefulWidget {
  @override
  _PanelRecommendationState createState() => _PanelRecommendationState();
}

class _PanelRecommendationState extends State<PanelRecommendation> {
  String? _electricityConsumption;
  // String? _roofSpace;
  int? energy_consumption;
  String? roofspace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: const Text('Panel Recommendation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'RENEWIFY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Dashboard(), // Navigate to Dashboard widget
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.wb_sunny),
              title: const Text('Solar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //builder: (context) => const SolarServices(), // Navigate to SolarServices widget
                    builder: (context) =>
                        const Dashboard(), // Navigate to SolarServices widget
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Subsidies/Loans'),
              onTap: () {
                // Handle Subsidies/Loans navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_gas_station),
              title: const Text('Biogas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //builder: (context) => const BiogasServices(), // Navigate to BiogasServices widget
                    builder: (context) =>
                        const Dashboard(), // Navigate to SolarServices widget
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.electric_bolt),
              title: const Text('Electricity'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.update),
              title: const Text('Updates'),
              onTap: () {
                // Handle Updates navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Energy Market'),
              onTap: () {
                // Handle Energy Market navigation
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle Settings navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle Logout navigation
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Kindly enter the following details according to your household!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Electricity consumption',
                border: OutlineInputBorder(),
              ),
              items: <String>['Less than 400 units', 'More than 400 units']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _electricityConsumption = newValue;
                  energy_consumption =
                      newValue == 'Less than 400 units' ? 300 : 500;
                });
              },
              value: _electricityConsumption,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter your District name...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter roofspace in square feet',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  roofspace = value;
                });
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                if (energy_consumption != null && roofspace != null) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              const SizedBox(height: 16),
                              const Text('Loading...'),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                  var url = Uri.parse(
                      'https://renewify-panel-recommendation.onrender.com/recommend?rooftop_space=$roofspace&power_consumption=$energy_consumption');
                  var response = await http.get(url);

                  Navigator.pop(context); // Dismiss the loading dialog

                  if (response.statusCode == 200) {
                    var responseData = json.decode(response.body);
                    if (responseData['panel_type_recommended'] ==
                        'polycrystalline') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              thingstoknow(), // Navigate to thingstoknow widget
                        ),
                      );
                    } else if (responseData['panel_type_recommended'] ==
                        'monocrystalline') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Dashboard(), // Navigate to monitoring widget
                        ),
                      );
                    }
                  } else {
                    // Handle error response
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to fetch recommendation')),
                    );
                  }
                } else {
                  // Handle null values
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all the fields')),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'Recommend',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
