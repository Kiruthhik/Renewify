import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'biomonitor.dart';
import 'center_biogas.dart';
import 'dashboard.dart';
import 'requirement.dart';

class BiogasServices extends StatefulWidget {
  const BiogasServices({Key? key}) : super(key: key);

  @override
  _BiogasServicesState createState() => _BiogasServicesState();
}

class _BiogasServicesState extends State<BiogasServices> {
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_pageController.page == 3) {
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: const Text('Biogas Services'),
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
                    builder: (context) =>
                        const BiogasServices(), // Navigate to BiogasServices widget
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SizedBox(
            height: 200,
            child: PageView(
              controller: _pageController,
              children: [
                _buildPageViewItem('assets/images/carb1.png'),
                _buildPageViewItem('assets/images/carb2.png'),
                _buildPageViewItem('assets/images/carb3.png'),
                _buildPageViewItem('assets/images/carb4.png'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: _buildPageIndicator(_pageController, 4),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: [
              _buildServiceItem(
                'Requirement Criteria',
                Icons.note_alt,
                context,
                onTap: () {},
              ),
              _buildServiceItem(
                'AR Visualization',
                Icons.view_in_ar,
                context,
                url: 'https://playcanv.as/b/ddc5934c',
                onTap: () {},
              ),
              _buildServiceItem(
                'Monitor',
                Icons.monitor,
                context,
                onTap: () {},
              ),
              _buildServiceItem(
                'Contact BioGas centers',
                Icons.call,
                context,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageViewItem(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPageIndicator(PageController controller, int itemCount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            double selectedness = Curves.easeOut.transform(
              max(
                0.0,
                1.0 - (controller.page! - index).abs(),
              ),
            );
            double zoom = 1.0 + (selectedness * 0.5);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: 8.0 * zoom,
              height: 8.0 * zoom,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildServiceItem(String title, IconData icon, BuildContext context,
      {String? url, required Null Function() onTap}) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () async {
          // Handle navigation
          if (url != null) {
            bool? result = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Kindly notice'),
                  content: Text(
                      'Please make sure you place your device camera facing towards an empty space.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
            if (result == true && await canLaunch(url)) {
              await launch(url);
            }
          } else {
            switch (title) {
              case 'Requirement Criteria':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RequirementPage(),
                  ),
                );

                break;
              case 'Monitor':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MonitorBiogasPage(),
                  ),
                );
                break;
              case 'Contact BioGas centers':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BiogasCenters(),
                  ),
                );
                // Implement navigation for Contact BioGas centers
                break;
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0), // Added padding
                child: Icon(
                  icon,
                  size: 50,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
