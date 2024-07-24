import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'biogas_services.dart';
import 'dashboard.dart';
import 'main.dart';
import 'monitoring.dart';
import 'post_view_page.dart';
import 'settings.dart';
import 'shop.dart';
import 'solarservices.dart';

class subsidies extends StatelessWidget {
  const subsidies({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.all(8.0),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Solar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildSubsidyContainer(context, 'PRADAN MANDIRI SCHEME', 'Subsidy',
              'https://www.pmsuryaghar.gov.in/', 'assets/images/pradhan.png'),
          _buildSubsidyContainer(
              context,
              'Union Roof Top Solar Scheme (URTS)',
              'Loan provided for installation of Grid connected Rooftop Solar',
              'https://www.unionbankofindia.co.in/english/urts.aspx',
              'assets/images/union.png'),
          _buildSubsidyContainer(
              context,
              'SBI Surya Ghar',
              'Loan for Solar Top',
              'https://sbi.co.in/web/personal-banking/loans/pm-surya-ghar-loan-for-solar-roof-top',
              'assets/images/sbi.webp'),
          _buildSubsidyContainer(
              context,
              'Central Bank of India Roof Top Solar Loan Scheme',
              'Loan Amount assuming cost of Solar at Rs. 70000 per KW.',
              'https://www.centralbankofindia.co.in/en/Roof-Top-Solar-Loan-Scheme',
              'assets/images/central.jpg'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Biogas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildSubsidyContainer(
              context,
              'Bank of Baroda',
              'Scheme for Financing Compressed Biogas (CBG)',
              'https://www.bankofbaroda.in/business-banking/rural-and-agri/loans-and-advances/scheme-for-financing-compressed-bio-gas',
              'assets/images/baroda.png'),
          _buildSubsidyContainer(
              context,
              'Union CBG (Compressed Bio-Gas) Scheme',
              'Loan for setting up of projects for production of CBG',
              'https://www.unionbankofindia.co.in/english/union-cbg-scheme.aspx',
              'assets/images/union.png'),
          _buildSubsidyContainer(
              context,
              'State Bank Scheme',
              'Scheme for setting up of Compressed Bio-Gas (CBG) projects',
              'https://sbi.co.in/web/get-business-product-information/financing-for-compressed-bio-gas',
              'assets/images/sbi.webp'),
          _buildSubsidyContainer(
              context,
              'SATAT BIO ENERGY SCHEME (SBES)',
              'Scheme for providing support for recovery of energy in the form of Biogas under SATAT',
              'https://satat.co.in/satat/#/',
              'asset/images/satat.png'),
        ],
      ),
    );
  }

  Widget _buildSubsidyContainer(BuildContext context, String title,
      String subtitle, String url, String logoPath) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(logoPath),
          radius: 24,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: ElevatedButton(
          onPressed: () async {
            final Uri uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            } else {
              throw 'Could not launch $url';
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text('View'),
        ),
      ),
    );
  }
}
