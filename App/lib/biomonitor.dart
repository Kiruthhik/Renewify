import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'biogas_services.dart';
import 'subsidies.dart';
import 'dashboard.dart';
import 'solarservices.dart';

class MonitorBiogasPage extends StatefulWidget {
  @override
  _MonitorBiogasPageState createState() => _MonitorBiogasPageState();
}

class _MonitorBiogasPageState extends State<MonitorBiogasPage> {
  double bioGasWeight = 20.0; // Sample input weight for Bio Gas (in kg)
  double lpgGasWeight = 6; // Sample input weight for LPG Gas (in kg)
  final double maxWeight = 25.0; // Maximum weight of a full cylinder (in kg)
  bool hasBioGas = true; // Assume user has Bio Gas by default
  bool hasLpgGas = true; // Assume user has LPG Gas by default

  @override
  Widget build(BuildContext context) {
    double bioGasPercentage = (bioGasWeight / maxWeight) * 100;
    double lpgGasPercentage = (lpgGasWeight / maxWeight) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gas Monitoring'),
        backgroundColor: Colors.green,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.green),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.green),
            onPressed: () {
              // Handle profile action
            },
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
                    builder: (context) =>
                        const SolarServices(), // Navigate to SolarServices widget
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
                        const subsidies(), // Navigate to subsidies widget
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
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => SolarElectricityMonitoringPage(), // Navigate to Screen widget
              //     ),
              //   );
              // },
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle button action
                },
                child: const Text('Find your Gas level'),
              ),
              const SizedBox(height: 20),
              buildGasLevelContainer(
                context,
                'Bio Gas Level left',
                Icons.eco, // Cylinder icon for Bio Gas
                bioGasPercentage,
                hasBioGas,
              ),
              const SizedBox(height: 20),
              buildGasLevelContainer(
                context,
                'LPG Gas Level left',
                FontAwesomeIcons.fire, // Cylinder icon for LPG Gas
                lpgGasPercentage,
                hasLpgGas,
              ),
              const SizedBox(height: 20),
              buildGasLeakContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGasLevelContainer(BuildContext context, String title,
      IconData iconData, double percentage, bool isEnabled) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isEnabled ? Colors.white : Colors.grey[300],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: 50,
                color: isEnabled ? Colors.green : Colors.grey,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: percentage / 100,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                      minHeight: 20,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${percentage.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGasLeakContainer() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'GAS Leak Detection',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Add numbers which should be notified in case of gas leakage:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Number 1: 8610236842',
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
            ),
          ),
          const Text(
            'Number 2: 9876543210',
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
            ),
          ),
          const Text(
            'Number 3: 9742412636',
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
