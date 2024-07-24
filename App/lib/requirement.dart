import 'package:flutter/material.dart';

import 'biogas_services.dart';
import 'dashboard.dart';
import 'solarservices.dart';
import 'subsidies.dart';

class RequirementPage extends StatefulWidget {
  const RequirementPage({Key? key}) : super(key: key);

  @override
  _RequirementPageState createState() => _RequirementPageState();
}

class _RequirementPageState extends State<RequirementPage> {
  final List<bool> _isChecked = List<bool>.filled(8, false);
  bool _isTermsChecked = false; // To track the terms and conditions checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: const Text('Requirement Criteria'),
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
                    builder: (context) => const Dashboard(),
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
                    builder: (context) => const SolarServices(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Subsidies/Loans'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const subsidies(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_gas_station),
              title: const Text('Biogas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BiogasServices(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.electric_bolt),
              title: const Text('Electricity'),
            ),
            ListTile(
              leading: const Icon(Icons.update),
              title: const Text('Updates'),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Energy Market'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRequirementItem(0,
                'Ensure there is land or space of about 5 square meters available for the installation.'),
            _buildRequirementItem(1,
                'The biogas digester must be installed in a place that allows adequate exposure to sunlight.'),
            _buildRequirementItem(2,
                'The site should be accessible to input feedstock materials and water.'),
            _buildRequirementItem(3,
                'The location must have adequate drainage to prevent water logging.'),
            _buildRequirementItem(4,
                'There should be enough distance from the biogas plant to nearby buildings and structures.'),
            _buildRequirementItem(5,
                'Ensure you have the required permissions from local authorities, if necessary.'),
            _buildRequirementItem(6,
                'Understand the maintenance requirements of the biogas system, including periodic inspections and servicing.'),
            _buildRequirementItem(7,
                'Ensure a steady supply of feedstock materials to sustain biogas production.'),
            _buildTermsAndConditions(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _isTermsChecked
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BiogasServices(),
                          ),
                        );
                      }
                    : null, // Disable the button if terms are not accepted
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementItem(int index, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: _isChecked[index],
            onChanged: (bool? value) {
              setState(() {
                _isChecked[index] = value!;
              });
              // Add actions to be performed on checkbox change if needed
            },
            activeColor: Colors.green,
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: _isTermsChecked,
            onChanged: (bool? value) {
              setState(() {
                _isTermsChecked = value!;
              });
            },
            activeColor: Colors.green,
          ),
          Expanded(
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'I have read and understood to the ',
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        'requirement criteria of RENEWIFY for installing biogas digester.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromARGB(255, 12, 94, 225),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
