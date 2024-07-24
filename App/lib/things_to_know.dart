import 'package:flutter/material.dart';

import 'biogas_services.dart';
import 'dashboard.dart';
import 'main.dart';
import 'monitoring.dart';
import 'post_view_page.dart';
import 'settings.dart';
import 'shop.dart';
import 'solarservices.dart';
import 'subsidies.dart';

class thingstoknow extends StatelessWidget {
  const thingstoknow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double containerHeight = 220.0;
    final double containerMargin = 16.0;
    final double iconSize = 32.0;
    final double iconRadius = 40.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text('Solar Services'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 15.0), // Adjust top padding here
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()),
                        );
                      },
                      child: Image.asset(
                        'assets/images/logo1.png', // Replace with your logo path
                        height: 40, // Adjust the height of the image
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()),
                        );
                      },
                      child: Text(
                        'RENEWIFY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20, // Adjust the font size if needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.wb_sunny),
              title: Text('Solar Installation'),
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
              leading: Icon(Icons.attach_money),
              title: Text('Subsidies /Loans'),
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
              leading: Icon(Icons.local_gas_station),
              title: Text('Biogas'),
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
              leading: Icon(Icons.electric_bolt),
              title: Text('Electricity'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SolarElectricityMonitoringPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.podcasts),
              title: Text('Green Edge'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostViewPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Energy Market'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountSettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildContainer(
              color: const Color.fromARGB(255, 193, 255, 114),
              icon: Icons.info,
              title: 'Cost of Solar Installation',
              text:
                  'The average cost of a solar installation today is between Rs.15,000 to Rs.20,000 per kilowatt, depending on the size of the system and other factors.',
              containerHeight: containerHeight,
              iconSize: iconSize,
              iconRadius: iconRadius,
              containerMargin: containerMargin,
            ),
            _buildContainer(
              color: Color.fromARGB(235, 156, 252, 115),
              icon: Icons.warning,
              title: 'Subsidies for Solar Installations',
              text:
                  'Subsidies for solar installations can cover up to 30% of the total cost, depending on the state and the specific program.',
              containerHeight: containerHeight,
              iconSize: iconSize,
              iconRadius: iconRadius,
              containerMargin: containerMargin,
            ),
            _buildContainer(
              color: const Color.fromARGB(255, 193, 255, 114),
              icon: Icons.help,
              title: 'Payback Period',
              text:
                  'The payback period for a solar installation can range from 3 to 7 years, depending on the cost of electricity and the amount of sunlight your location receives.',
              containerHeight: containerHeight,
              iconSize: iconSize,
              iconRadius: iconRadius,
              containerMargin: containerMargin,
            ),
            _buildContainer(
              color: const Color.fromARGB(255, 162, 241, 129),
              icon: Icons.check_circle,
              title: 'Financing Options',
              text:
                  'Financing options for solar installations include loans, leases, and power purchase agreements (PPAs), which can help reduce the upfront cost.',
              containerHeight: containerHeight,
              iconSize: iconSize,
              iconRadius: iconRadius,
              containerMargin: containerMargin,
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 248, 246, 246),
    );
  }

  Widget _buildContainer({
    required Color color,
    required IconData icon,
    required String title,
    required String text,
    required double containerHeight,
    required double iconSize,
    required double iconRadius,
    required double containerMargin,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: containerMargin),
      padding: const EdgeInsets.all(16),
      height: containerHeight,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: CircleAvatar(
              radius: iconRadius / 2,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                size: iconSize,
                color: color,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: iconRadius + 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  text,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
