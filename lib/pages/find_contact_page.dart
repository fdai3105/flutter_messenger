part of 'pages.dart';

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
            FindContactInput(
              valueChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _search = value;
                  }
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder<List<Contact>>(
                future: ContactRepository().findContact(_search),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return FindContactItem(
                                  contact: snapshot.data[index],
                                );
                              }),
                        );
                    } else {
                      return CantFind();
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
