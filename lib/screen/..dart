import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime dateTime = DateTime(2022);
  String? currentTime;
  List<String> storedTimes = [];

  storeData() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? myString = prefs.getStringList("notedTime");

    setState(() {
      storedTimes.addAll(myString!);
    });
  }

  Future currantTime() async {
    return currentTime = TimeOfDay.now().format(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    storeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
            vertical: 30,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Timer",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w900,
                        fontSize: 43,
                        color: Color.fromRGBO(49, 68, 105, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                // Text("${currentTime}"),
                // Text("${dateTime}"),
                FutureBuilder(
                  future: currantTime()..then((value) => setState(() {})),
                  builder: (context, snapShot) {
                    currentTime = snapShot.data as String?;

                    return Text(
                      "${currentTime!.split(":")[0]} : ${currentTime!.split(":")[1]}",

                      ///"00 : 00 : 00",
                      style: TextStyle(
                        color: Color.fromRGBO(49, 68, 105, 1),
                        fontSize: 58,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),

                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setStringList("notedTime", [
                        "${currentTime!.split(":")[0]} : ${currentTime!.split(":")[1]}"
                      ]);
                      List<String>? myString = prefs.getStringList("notedTime");

                      storedTimes.add(myString.toString());

                      await prefs
                          .setStringList("notedTime", ["${storedTimes}"]);
                    });
                  },
                  child: const Text(
                    'Mark My Thought',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.black.withOpacity(0.9),
                    ),
                    fixedSize: MaterialStateProperty.all(const Size(200, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 70,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: storedTimes.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                "${storedTimes[index]}",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future openDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Your Massage"),
          content: TextField(
            decoration: InputDecoration(hintText: "Enter Msg"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}