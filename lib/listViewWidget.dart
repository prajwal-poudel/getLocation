import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({Key? key}) : super(key: key);

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

enum HumanGender { Male, Female, Others }

class _ListViewWidgetState extends State<ListViewWidget> {
  List<Map<String, dynamic>> users = [
    {"name": "John", "number": "98876654321", "code": "+977"},
    {"name": "Seth", "number": "9855231987", "code": "+977"},
    {"name": "Roman", "number": "980000054", "code": "+977"},
    {"name": "Mark", "number": "9800552311", "code": "+977"},
    {"name": "Paul", "number": "9752444298", "code": "+977"},
  ];
  static List<String> code = ["+977", "+1", "+91", "+44"];
  String selectedValue = code.first;
  HumanGender? selectedGender = HumanGender.Male;
  bool isSelected = false;
  TextEditingController fullnameController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 400,
                color: Colors.grey,
                child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, index) => Column(
                    children: [
                      ListTile(
                        title: Text(users[index]["name"]),
                        subtitle: Text(users[index]["code"] +
                            "-" +
                            users[index]["number"]),
                        leading: Icon(Icons.person),
                        trailing: IconButton(
                            onPressed: () {
                              makePhoneCall(users[index]["number"]);
                              _launchInBrowser(
                                  Uri.parse("http://www.facebook.com"));
                            },
                            icon: Icon(
                              Icons.phone_outlined,
                              size: 45,
                              color: Color.fromRGBO(40, 104, 43, 1),
                            )),
                      ),
                      Divider(
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 70),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: fullnameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "FullName", hintText: "Ram Badhur tamang"),
                    ),
                    Row(
                      children: [
                        //DropDown Button
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: selectedValue,
                              items: code.map((String e) {
                                return DropdownMenuItem<String>(
                                    value: e, child: Text(e));
                              }).toList(),
                              onChanged: (item) {
                                setState(() {
                                  selectedValue = item.toString();
                                });
                              }),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            child: TextFormField(
                              controller: numberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Phone Number",
                                  hintText: "9811110011"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Map<String, dynamic> newMap = {
                            "name": fullnameController.text,
                            "number": numberController.text,
                            "code": selectedValue
                          };
                          print(newMap);
                          setState(() {
                            users.add(newMap);
                          });
                          fullnameController.clear();
                          numberController.clear();
                        },
                        child: Text("Save")),
                    Row(
                      children: [
                        Radio<HumanGender>(
                            value: HumanGender.Male,
                            groupValue: selectedGender,
                            onChanged: (val) {
                              setState(() {
                                selectedGender = val;
                              });
                            }),
                        Radio<HumanGender>(
                            value: HumanGender.Female,
                            groupValue: selectedGender,
                            onChanged: (val) {
                              setState(() {
                                selectedGender = val;
                              });
                            }),
                        Radio<HumanGender>(
                            value: HumanGender.Others,
                            groupValue: selectedGender,
                            onChanged: (val) {
                              setState(() {
                                selectedGender = val;
                              });
                            }),
                      ],
                    ),
                    Checkbox(
                        value: isSelected,
                        onChanged: (val) {
                          setState(() {
                            isSelected = val!;
                          });
                        })
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
