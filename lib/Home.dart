import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'الواجهة الرئيسية',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.telegram),
              Icon(Icons.abc),
              Icon(Icons.phone),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'مرحبًا بك في تطبيق فندق Turky_Stars',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    create_card(
                      context,
                      color: Colors.blueGrey,
                      icon: Icons.home_outlined,
                      label: 'عرض الغرف ',
                      rote: 'Show_rooms',
                    ),
                    create_card(
                      context,
                      color: Colors.orange,
                      icon: Icons.group,
                      label: 'عرض العملاء',
                      rote: 'Show_Clints',
                    ),

                    create_card(
                      context,
                      color: Colors.blueAccent,
                      icon: Icons.collections_bookmark_outlined,
                      label: 'عرض الحجوزات',
                      rote: 'Show_Booking',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell create_card(
    BuildContext context, {
    Color? color,
    IconData? icon,
    String? label,
    String? rote,
  }) => InkWell(
    onTap: () {
      Navigator.pushNamed(context, rote!);
    },
    child: Card(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 70),
          Text(label!, style: TextStyle(fontSize: 20)),
        ],
      ),
    ),
  );
}
