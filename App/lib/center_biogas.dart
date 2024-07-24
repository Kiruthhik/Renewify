import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'biogas_services.dart';
import 'dashboard.dart';
import 'solarservices.dart';
import 'subsidies.dart';

class BiogasCenters extends StatelessWidget {
  const BiogasCenters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: const Text('Contact Centers'),
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
                        const Dashboard(), // Navigate to BiogasServices widget
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
                    builder: (context) =>
                        const SolarServices(), // Navigate to BiogasServices widget
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
                    builder: (context) =>
                        const subsidies(), // Navigate to BiogasServices widget
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
                    builder: (context) =>
                        const BiogasServices(), // Navigate to BiogasServices widget
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
            const Text(
              'CONTACT THE BIOGAS INSTALLATION CENTERS NEAR YOU!!',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 20),
            _buildContactCenter(
              'HRG Solutions',
              '1025,Balaji Chambers,E Ward Rajaram Road, Retteri, Chennai',
              '9674028382',
              'contacthomebiogas@gmail.com',
              'https://www.homebiogas.com',
            ),
            _buildContactCenter(
              'Diamond engineering enterprises',
              'No.122/38 Near Tondiarpet Market, Tondiarpet Chennai - 600081, Tamil Nadu, India',
              '8048600293',
              'Diamondenggchennai@gmail.com',
              'https://www.indiamart.com/diamond-engineering-enterprises',
            ),
            _buildContactCenter(
              'Flexi Balloon Biogas Plant',
              'No. 827, Nandgam, District Kheda, Taluka Mahudha, Ahmedabad-387335, Gujarat, India',
              '8047828100',
              'Balloonbiogas@gmail.com',
              'https://www.indiamart.com/flexiballoonbiogasplant-ahmedabad/?pid=12784349097&c_id=424&mid=121272&pn=Mini+Digester+1',
            ),
            _buildContactCenter(
              'ORCCI Eco Products',
              '1a 4, Monish Enclave, Sri Abinandhan Nagar, Nanmangalam, Chengalpattu, Nanmangalam Chennai - 600129, Tamil Nadu, India',
              '8043870034',
              'contactorcciecoprouduct@gmail.com',
              'https://www.indiamart.com/orcci-eco-products',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCenter(
      String name, String address, String phone, String email, String website) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(address),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconButton(
                icon: Icons.phone,
                tooltip: phone,
                onTap: () => _launchUrl('tel:$phone'),
              ),
              _buildIconButton(
                icon: Icons.email,
                tooltip: email,
                onTap: () => _launchUrl('mailto:$email'),
              ),
              _buildIconButton(
                icon: Icons.link,
                onTap: () => _launchUrl(website),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
    String? tooltip,
  }) {
    return Tooltip(
      message: tooltip ?? '',
      child: IconButton(
        icon: Icon(icon, color: Colors.green),
        onPressed: onTap,
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
