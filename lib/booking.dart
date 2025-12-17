import 'package:flutter/material.dart';
import 'dbhelber.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.data});
  final Map data;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<Map> bookings = [];

  List<Map> filtterbookings = [];

  void loadRent() async {
    dynamic data = await Dbhelber.getRents();
    setState(() {
      debugPrint(data.toString());
      bookings = data;
      filtterbookings = data;
      widget.data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadRent();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController groubController = TextEditingController();
  String? TypePayController = null;
  final TextEditingController cardController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   Dbhelber.create_data_baase();
  //   widget.data;
  // }

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
        // drawer: Drawer(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       Icon(Icons.telegram),
        //       Icon(Icons.abc),
        //       Icon(Icons.phone),
        //     ],
        //   ),
        // ),

        // يحتوي على كامل الواجهة
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // هوامش الصفحة
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // توسيط العناصر
              children: [
                // ------------------ بيانات الغرفة ------------------
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      // صورة الغرفة الدائرية
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          "صورة\nالغرفة",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 20),
                      // نصوص نوع الغرفة وسعر الغرفة
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " ${widget.data["id_room"]}",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "نوع الغرفة: ${widget.data["type_room"]}",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "السعر:${widget.data["price_room"]} ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                // ------------------ عنوان إدخال البيانات ------------------
                Text(
                  "ادخل بياناتك",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                // ------------------ حقل اسم العميل ------------------
                buildGradeRow('اسم العميل', nameController, TextInputType.name),

                SizedBox(height: 15),

                // ------------------ حقل رقم الهاتف ------------------
                buildGradeRow(
                  'رقم الهاتف',
                  phoneController,
                  TextInputType.phone,
                ),
                SizedBox(height: 15),

                // ------------------ حقل عدد الأفراد ------------------
                buildGradeRow(
                  'عدد الافراد',
                  groubController,
                  TextInputType.number,
                ),

                SizedBox(height: 15),

                // ------------------ نوع الدفع ------------------
                DropdownButtonFormField(
                  value: TypePayController,
                  decoration: InputDecoration(border: OutlineInputBorder()),

                  hint: Text('اختر طريقة للدفع'),

                  items: ["كاش", "فيزة"]
                      .map<DropdownMenuItem<String>>(
                        (d) => DropdownMenuItem<String>(
                          value: d,
                          child: Text(d.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    TypePayController = value!;
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),

                // ------------------ رفع هوية العميل ------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_library, size: 45), // أيقونة الرفع
                    SizedBox(width: 10),
                    Text("اختر صورة: هوية العميل"),
                  ],
                ),

                SizedBox(height: 25),

                // ------------------ زر الإرسال ------------------
                SizedBox(
                  width: double.infinity, // عرض الزر بكامل الشاشة
                  child: ElevatedButton(
                    onPressed: () async{
                      if (nameController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty &&
                          groubController.text.isNotEmpty &&
                          TypePayController!.isNotEmpty) {
                        Dbhelber.insertClints(
                          nameController.text,
                          phoneController.text,
                          groubController.text,
                          TypePayController!,
                        );
                        dynamic idd = await Dbhelber.maxClint();

                        Dbhelber.insertRents(
                          idd,
                          widget.data["id_room"],
                          "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
                        );

                        Navigator.pushNamed(context, 'Show_Clints');
                      }
                    }, // هنا تضع وظيفة الإرسال
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text("ارسل الطلب", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField buildGradeRow(
    String title,
    TextEditingController controller,
    TextInputType keyboardType,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title, // نص داخل الحقل
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // زوايا الحقل
        ),
      ),
      keyboardType: keyboardType, // لوحة أرقام للدرجات
    );
  }
}
