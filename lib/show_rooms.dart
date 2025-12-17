import 'package:business_card/booking.dart';
import 'package:business_card/dbhelber.dart';
import 'package:flutter/material.dart';
// import 'dbhelber.dart';

class Show_rooms extends StatefulWidget {
  const Show_rooms({super.key});

  @override
  State<Show_rooms> createState() => Show_roomsState();
}

class Show_roomsState extends State<Show_rooms> {
  List<Map> rooms = [];

  List<Map> filtterRooms = [];
  // TextEditingController type_Room = TextEditingController();
  // TextEditingController count_Bed = TextEditingController();
  // TextEditingController date_Rent = TextEditingController();

  void loadRooms() async {
    dynamic data = await Dbhelber.getRooms();

    setState(() {
      data = data.where((data) {
      return data['isEmpty'] == 0;
    }).toList();
      filtterRooms = data;
      rooms = data;
    });
  }

  @override
  void initState() {
    Dbhelber.create_data_baase();
    super.initState();
    rooms = rooms.where((data) {
      return data['isEmpty'] == 0;
    }).toList();
    loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('عرض الغرف'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        // drawer: Directionality(
        //   textDirection: TextDirection.rtl,
        //   child: Drawer(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         Icon(Icons.telegram),
        //         Icon(Icons.abc),
        //         Icon(Icons.phone),
        //       ],
        //     ),
        //   ),
        // ),
        body: ListView.builder(
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            return Card(
              color:  const Color.fromARGB(255, 249, 247, 247),
              child: ListTile(
                leading: CircleAvatar(child: Text('${rooms[index]['id_room']}')),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("نوع الغرفة: ${rooms[index]['type_room']}"),
                    Text("عدد الأسرة: ${rooms[index]['count_bed']}"),
                    Text("السعر:  ${rooms[index]["price_room"]}"),
                  ],
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, 'BookingPage');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BookingPage(data: rooms[index]);
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        // minimumSize: Size(5, 8),
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(5),
                        ),
                      ),
                      child: Text('طلب حجز'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
