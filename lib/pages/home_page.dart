part of 'pages.dart';

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
            ConversationTab(_tabController,),
            ContactTab(),
            SettingTab(),
          ],
        )),
        bottomNavigationBar: HomeBottomNavigation(tabController: _tabController,)
      ),
    );
  }
}