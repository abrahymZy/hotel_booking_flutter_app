import 'package:flutter/material.dart';

class Show_Detalls_2 extends StatelessWidget {
  

  final Map<dynamic, dynamic> details;

  Show_Detalls_2({super.key, required this.details}); // رقم الحجز ثابت بدون استقبال من main

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('معلومات الحجز'),
          centerTitle: true,
          backgroundColor: Colors.blue,
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
                        const Divider(thickness: 2),

                        gradeRow(
                          "اسم العميل",
                          details['name_clint'] ?? "غير موجود",
                        ),

                        gradeRow(
                          "رقم الغرفة",
                          details['id_room'].toString(),
                        ),

                        gradeRow(
                          "نوع الغرفة",
                          details['price_room'],
                        ),

                        gradeRow(
                          "تاريخ الحجز",
                          details['date_rent'],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

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
            value.toString(),
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
