import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_chat/config/ui.dart';
import 'package:flutter_bloc_chat/models/user.dart';
import 'package:flutter_bloc_chat/repositories/contact_repository.dart';
import 'package:flutter_bloc_chat/widgets/widgets.dart';

class FindContactPage extends StatefulWidget {
  @override
  _FindContactPageState createState() => _FindContactPageState();
}

class _FindContactPageState extends State<FindContactPage> {
  String _search = "";

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: UI.appBarBackground,
        title: Text(
          "Find someone",
          style: TextStyle(color: UI.appBarTextColor),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: UI.appBarIconColor),
      ),
      body: SafeArea(
          child: Container(
        color: UI.bodyBackground,
        padding: UI.paddingTop,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _size.width - 20,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    decoration: UI.textDecoration.copyWith(
                        prefixIcon: const Icon(
                          Icons.find_replace,
                        ),
                        hintText: "Search"),
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          _search = value;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder<List<User>>(
                future: ContactRepository().findContacts(_search),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isNotEmpty) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return FindContactItem(
                                  user: snapshot.data[index],
                                );
                              }),
                        );
                      } else {
                        return CantFind();
                      }
                    } else {
                      return Container();
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      height: 50,
                      width: 50,
                      child: const CircularProgressIndicator(),
                    );
                  } else {
                    return const Text("Error unknow");
                  }
                })
          ],
        ),
      )),
    );
  }
}
