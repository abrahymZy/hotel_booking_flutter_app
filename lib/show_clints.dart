import 'package:business_card/Dbhelber.dart';
import 'package:flutter/material.dart';
// import 'dbhelber.dart';

class Show_Clints extends StatefulWidget {
  const Show_Clints({super.key});

  @override
  State<Show_Clints> createState() => Show_ClintsState();
}

class Show_ClintsState extends State<Show_Clints> {
  List<Map> Clints = [];

  List<Map> filtterClints = [];
  void loadClint() async {
    dynamic data = await Dbhelber.getClint();
    setState(() {
      
      Clints = data;
      filtterClints = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadClint();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('عرض العملاء'),
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
        body: ListView.builder(
          itemCount: Clints.length,
          itemBuilder: (context, index) {
            return Card(
              color:  const Color.fromARGB(255, 249, 247, 247),
              child: ListTile(
                leading: CircleAvatar(child: Text('${(index + 1)}')),

                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("اسم العميل: ${Clints[index]['name_clint']}"),
                    Text("رقم العميل: ${Clints[index]['phone_clint']}"),
                    Text("عدد الافراد:  ${Clints[index]["count_clint"]}"),
                    Text("نوع الدفع:  ${Clints[index]["type_pay"]}"),
                  ],
                ),
                // trailing: Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     ElevatedButton(
                //       onPressed: () {},
                //       style: ElevatedButton.styleFrom(
                //         minimumSize: Size(10, 5),
                //         backgroundColor: Colors.lightBlueAccent,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadiusGeometry.circular(5),
                //         ),
                //       ),
                //       child: Text(' التفاصيل'),
                //     ),
                //   ],
                // ),
              ),
            );
          },
        ),
      ),
    );
  }
}
