import 'package:flutter/material.dart';
import 'biogas_services.dart';
import 'main.dart';
import 'monitoring.dart';
import 'post_view_page.dart';
import 'settings.dart';
import 'shop.dart';
import 'dart:math';
import 'solarservices.dart';
import 'subsidies.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;
  final List<String> tutorialTexts = [
    "Welcome to the Dashboard! Here you can access various features.",
    "Click on 'Solar Installation' to start your solar journey.",
    "Check out 'Subsidies/Loans' for financial assistance.",
    "Explore 'Biogas' for green energy solutions.",
    "Monitor 'Electricity' usage in real-time.",
    "Visit 'Green Edge' for the latest news and updates.",
    "Shop in the 'Energy Market' for renewable products.",
  ];
  final List<GlobalKey> containerKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  int currentTutorialIndex = 0;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );
    _controller.repeat();

    animation = Tween<double>(begin: -400, end: 0).animate(_controller);
    animation.addListener(() {
      setState(() {});
    });

    // Show the first tutorial alert when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTutorialOverlay();
    });
  }

  void _showTutorialOverlay() {
    if (currentTutorialIndex >= tutorialTexts.length) return;

    RenderBox? renderBox = containerKeys[currentTutorialIndex]
        .currentContext
        ?.findRenderObject() as RenderBox?;
    Offset? containerPosition = renderBox?.localToGlobal(Offset.zero);
    Size screenSize = MediaQuery.of(context).size;

    if (containerPosition != null) {
      _removeExistingOverlay();

      _overlayEntry = OverlayEntry(
        builder: (context) {
          final double maxWidth = screenSize.width * 0.8; // 80% of screen width
          final double maxHeight =
              screenSize.height * 0.6; // 60% of screen height

          final double overlayWidth = maxWidth;
          final double overlayHeight = min(
            maxHeight,
            MediaQuery.of(context).size.height - containerPosition.dy - 50,
          );

          final double leftPosition =
              (containerPosition.dx + (renderBox?.size.width ?? 0) / 2) -
                  (overlayWidth / 2);
          final double topPosition = containerPosition.dy + 50;

          return Positioned(
            top: topPosition.clamp(0.0, screenSize.height - overlayHeight),
            left: leftPosition.clamp(0.0, screenSize.width - overlayWidth),
            width: overlayWidth,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10)],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize:
                        MainAxisSize.min, // Minimize size to fit content
                    children: [
                      Text('Tutorial',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(
                        tutorialTexts[currentTutorialIndex],
                        style: TextStyle(
                            fontSize: 14), // Adjust text size to fit content
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            child: Text('OK'),
                            onPressed: () {
                              setState(() {
                                currentTutorialIndex++;
                              });
                              _removeExistingOverlay();
                              _showTutorialOverlay();
                            },
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            child: Text('Skip'),
                            onPressed: () {
                              setState(() {
                                currentTutorialIndex++;
                              });
                              _removeExistingOverlay();
                              _showTutorialOverlay();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );

      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _removeExistingOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _controller.dispose();
    _removeExistingOverlay(); // Remove overlay when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
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
                        'assets/images/logo1.png',
                        height: 40,
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
                          fontSize: 20,
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
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        elevation: 0,
        title: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'KEERTHANA',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Power up your space!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.person, color: Colors.black),
              onPressed: () {}),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(12.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Animated wave background
          Positioned(
            bottom: 0,
            right: animation.value,
            child: ClipPath(
              clipper: MyWaveClipper(),
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  color: Colors.green.shade200,
                  width: 700,
                  height: 200,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: animation.value,
            child: ClipPath(
              clipper: MyWaveClipper(),
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  color: Colors.green.shade200,
                  width: 700,
                  height: 200,
                ),
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.only(top: 58.0, left: 8.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: <Widget>[
                      DashboardItem(
                        key: containerKeys[0],
                        title: 'Solar Installation',
                        icon: Icons.wb_sunny,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SolarServices(),
                            ),
                          );
                        },
                      ),
                      DashboardItem(
                        key: containerKeys[1],
                        title: 'Subsidies/Loans',
                        icon: Icons.attach_money,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const subsidies(),
                            ),
                          );
                        },
                      ),
                      DashboardItem(
                        key: containerKeys[2],
                        title: 'Biogas',
                        icon: Icons.local_gas_station,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BiogasServices(),
                            ),
                          );
                        },
                      ),
                      DashboardItem(
                        key: containerKeys[3],
                        title: 'Electricity',
                        icon: Icons.electric_bolt,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SolarElectricityMonitoringPage()),
                          );
                        },
                      ),
                      DashboardItem(
                        key: containerKeys[4],
                        title: 'Green Edge',
                        icon: Icons.podcasts,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostViewPage()),
                          );
                        },
                      ),
                      DashboardItem(
                        key: containerKeys[5],
                        title: 'Energy Market',
                        icon: Icons.shopping_cart,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ShopPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const DashboardItem({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.green,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Clipper for the wave
class MyWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 40.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 40.0);

    // Create Bezier Curve waves
    for (int i = 0; i < 10; i++) {
      if (i % 2 == 0) {
        path.quadraticBezierTo(
            size.width - (size.width / 16) - (i * size.width / 8),
            0.0,
            size.width - ((i + 1) * size.width / 8),
            size.height - 160);
      } else {
        path.quadraticBezierTo(
            size.width - (size.width / 16) - (i * size.width / 8),
            size.height - 120,
            size.width - ((i + 1) * size.width / 8),
            size.height - 160);
      }
    }

    path.lineTo(0.0, 40.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
