part of 'pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TabController _tabController;
  int currentPage = 0;

  List<Widget> _appBar() {
    final _appbar = [
      AppBar(
        title: Text(
          "Chats",
          style: UI.appBarTextStyle,
        ),
        leading: avatarButton(),
        titleSpacing: 5,
        backgroundColor: UI.appBarBackground,
        shadowColor: Colors.transparent,
      ),
      AppBar(
        title: Text(
          "Contacts",
          style: UI.appBarTextStyle,
        ),
        leading: avatarButton(),
        titleSpacing: 5,
        backgroundColor: UI.appBarBackground,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.findContact)),
        ],
      ),
    ];
    return _appbar;
  }

  Widget avatarButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.setting);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: ClipOval(
            child: Image.network(
          SharedPres.getUser().avatar,
        )),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 2, vsync: this);
    UserRepository().setUserOnlineStatus(isOnline: true);
    _tabController.addListener(() {
      setState(() {
        currentPage = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final userRep = UserRepository();
    switch (state) {
      case AppLifecycleState.inactive:
      // offline
        userRep.setUserOnlineStatus(isOnline: false);
        break;
      case AppLifecycleState.paused:
        print("App Paused");
        break;
      case AppLifecycleState.resumed:
      // online
        userRep.setUserOnlineStatus(isOnline: true);
        break;
      case AppLifecycleState.detached:
        print("App Suspending");
        break;
    }
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
            ConversationTab(
              _tabController,
            ),
            ContactTab(),
          ],
        )),
        bottomNavigationBar: HomeBottomNavigation(
          tabController: _tabController,
        ),
      ),
    );
  }
}
