import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'map_page.dart';
import 'panel_recom.dart';
import 'things_to_know.dart';
import 'package:url_launcher/url_launcher.dart';
import 'biogas_services.dart';
import 'dashboard.dart';
import 'main.dart';
import 'monitoring.dart';
import 'post_view_page.dart';
import 'settings.dart';
import 'shop.dart';
import 'subsidies.dart';

class SolarServices extends StatefulWidget {
  const SolarServices({Key? key}) : super(key: key);

  @override
  _SolarServicesState createState() => _SolarServicesState();
}

class _SolarServicesState extends State<SolarServices> {
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SizedBox(
            height: 200,
            child: PageView(
              controller: _pageController,
              children: [
                _buildPageViewItem('assets/images/car1.png'),
                _buildPageViewItem('assets/images/car2.png'),
                _buildPageViewItem('assets/images/car3.png'),
                _buildPageViewItem('assets/images/car4.png'),
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
                'Rooftop Analysis',
                Icons.api,
                context,
              ),
              _buildServiceItem(
                'Things to know',
                Icons.note_alt,
                context,
              ),
              _buildServiceItem(
                'Locate centers',
                Icons.location_on,
                context,
              ),
              _buildServiceItem(
                'Panel \n recommended',
                Icons.lightbulb,
                context,
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
        boxShadow: [
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

  Widget _buildServiceItem(String title, IconData icon, BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () async {
          // Handle navigation
          switch (title) {
            case 'Rooftop Analysis':
              const url = 'https://renewify-rooftop-analysiss.onrender.com';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
              break;
            case 'Things to know':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const thingstoknow(),
                ),
              );
              break;
            case 'Locate centers':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MapPage(), // Navigate to SolarViewPage widget
                ),
              );
              break;
            case 'Panel recommended':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PanelRecommendation(),
                ),
              );
              // Implement navigation for Panel recommendations
              break;
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
