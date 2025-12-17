import 'package:business_card/Dbhelber.dart';
import 'package:business_card/shw_detalls_2.dart';
import 'package:flutter/material.dart';

class Show_Booking extends StatefulWidget {
  const Show_Booking({super.key});

  @override
  State<Show_Booking> createState() => Show_BookingState();
}

class Show_BookingState extends State<Show_Booking> {
  List<Map> bookings = [
    // {'id_rent':1, 'id_clint':1,'id_room':3,'date_rent':'2025/1/3'},
    // {'id_rent':2, 'id_clint':2,'id_room':5,'date_rent':'2025/1/5'},
    // {'id_rent':3, 'id_clint':3,'id_room':6,'date_rent':'2025/2/7'},
    // {'id_rent':4, 'id_clint':4,'id_room':2,'date_rent':'2025/3/6'},
    // {'id_rent':5, 'id_clint':5,'id_room':9,'date_rent':'2025/3/10'},
  ];
  // TextEditingController txtName = TextEditingController();
  // TextEditingController textTerm = TextEditingController();
  // TextEditingController textEvaluation = TextEditingController();

  List<Map> filtterbookings = [];

  void loadRent() async {
    dynamic data = await Dbhelber.getRents();
    setState(() {
      debugPrint(data.toString());
      bookings = data;
      filtterbookings = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadRent();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('عرض الحجوزات'),
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
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              return Card(
                color: const Color.fromARGB(255, 249, 247, 247),
                child: ListTile(
                  leading: CircleAvatar(
                    maxRadius: 40,
                    child: Text("${bookings[index]['id_rent']}"),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("إسم العميل:  ${bookings[index]["name_clint"]}"),
                      Text("رقم الغرفة:  ${bookings[index]["id_room"]}"),
                      Text("تاريخ الحجز:  ${bookings[index]["date_rent"]}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Dbhelber.cancelRent(
                            bookings[index]["id_room"],
                            bookings[index]['id_rent'],
                          );
                          setState(() {
                            loadRent();
                          });
                        },
                        color: Colors.red,
                        icon: Icon(Icons.cancel), //Text('إلغاء الحجز'),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Show_Detalls_2(details: bookings[index]),
                            ),
                          );
                        },
                        color: Colors.blueAccent,
                        icon: Icon(Icons.more), //Text('عرض التفاصيل'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
