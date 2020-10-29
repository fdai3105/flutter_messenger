part of 'widgets.dart';

class HomeBottomNavigation extends StatelessWidget {
  final TabController tabController;

  const HomeBottomNavigation({Key key, this.tabController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TabBar(
        controller: tabController,
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
        indicatorColor: UI.primaryColor,
        unselectedLabelColor: UI.primaryColor.withOpacity(0.5),
      ),
    );
  }
}
