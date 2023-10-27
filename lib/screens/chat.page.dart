import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Fale conosco"),
        backgroundColor: Colors.indigo,
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight),
          _buildContactOptions(screenHeight),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildContactOptions(double screenHeight) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
            ),
            onPressed: () {
              launchWhatsApp('+5561123453211', 'Olá, estou usando o mercadoapp...');
            },
            icon: Icon(Icons.phone),
            label: Text('WhatsApp'),
          ),
          SizedBox(height: 10),
          Text(
            'Telefone',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              //color: Colors.black,
            ),
          ),
          ContactInfo(
            icon: Icons.phone,
            label: '+55 61 12345-3211',
            onTap: () {
              launchPhoneCall('+5561123453211');
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'E-mail',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              //color: Colors.black,
            ),
          ),
          ContactInfo(
            icon: Icons.email,
            label: 'carrabicho@carrabicho.com',
            onTap: () {
              launchEmail('carrabicho@carrabicho.com');
            },
          ),
        ],
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ContactInfo({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

void launchWhatsApp(String phone, String message) {
  // Implement your WhatsApp launch logic here
}

void launchPhoneCall(String phoneNumber) {
  // Implement your phone call launch logic here
}

void launchEmail(String email) {
  // Implement your email launch logic here
}
