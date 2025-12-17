import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// صفحة عرض درجات الطالب مباشرة
class Show_dgree_1 extends StatefulWidget {
  Show_dgree_1({Key? key}) : super(key: key);

  @override
  State<Show_dgree_1> createState() => Show_dgree_1State();
}

class Show_dgree_1State extends State<Show_dgree_1> {
  final TextEditingController studentData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // لجعل النصوص من اليمين لليسار
      child: Scaffold(
        appBar: AppBar(
          title: const Text('درجات الطالب'),
          centerTitle: true,
          backgroundColor: Colors.blue,
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
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'اسم الطالب',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(thickness: 2),
                  gradeRow('الواجبات', '60'),
                  gradeRow('النهائي', '60'),
                  gradeRow('تحريري', '60'),
                  gradeRow('المواشفية', '60'),
                  gradeRow('المجموع', '60'),
                  gradeRow('المعدل', '60'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // صف لعرض اسم الدرجة وقيمتها
  Widget gradeRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.black87),
          ),
          Text(
            value?.toString() ?? '—',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
