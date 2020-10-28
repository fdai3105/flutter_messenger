import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_chat/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc_chat/config/routes.dart';
import 'package:flutter_bloc_chat/config/ui.dart';
import 'package:flutter_bloc_chat/repositories/contact_repository.dart';
import 'package:flutter_bloc_chat/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int currentPage = 0;

  List<Widget> _appBar() {
    final _appbar = [
      AppBar(
        title: Text(
          "Chats",
          style: UI.appBarTextStyle,
        ),
        backgroundColor: UI.appBarBackground,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => context.bloc<AuthBloc>().add(LogoutAuthEvent()))
        ],
      ),
      AppBar(
        title: Text(
          "Contacts",
          style: UI.appBarTextStyle,
        ),
        backgroundColor: UI.appBarBackground,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.findContact)),
        ],
      ),
      AppBar(
        title: Text(
          "Settings",
          style: UI.appBarTextStyle,
        ),
        backgroundColor: UI.appBarBackground,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => context.bloc<AuthBloc>().add(LogoutAuthEvent()))
        ],
      ),
    ];
    return _appbar;
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentPage = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _appBar()[currentPage],
        body: SafeArea(
            child: TabBarView(
          controller: _tabController,
          children: [
            ConversationTab(tabController: _tabController,),
            ContactTab(),
            SettingTab(),
          ],
        )),
        bottomNavigationBar: Container(
          height: 50,
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.red,
            onTap: (index) {},
            tabs: const [
              Tab(
                icon: Icon(Icons.home),
                iconMargin: EdgeInsets.zero,
              ),
              Tab(
                icon: Icon(Icons.contacts),
                iconMargin: EdgeInsets.zero,
              ),
              Tab(
                icon: Icon(Icons.settings),
                iconMargin: EdgeInsets.zero,
              )
            ],
            indicatorColor: Colors.red,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ContactRepository().addContact("hoangphidai123@gmail.com");
          },
        ),
      ),
    );
  }
}