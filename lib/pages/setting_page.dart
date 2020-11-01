part of 'pages.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: UI.appBarIconColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Settings",
          style: UI.appBarTextStyle,
        ),
        elevation: 0,
        backgroundColor: UI.appBarBackground,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: UI.paddingTop,
          color: UI.bodyBackground,
          child: Column(
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#FF9F6B"),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 70,
                        width: 70,
                        child: ClipOval(
                            child: Image.network(SharedPres.getUser().avatar))),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          SharedPres.getUser().name,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Edit info",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SwitchListTile(
                secondary: Icon(
                  Icons.brightness_2,
                  size: 36,
                ),
                title: Text("Dark mode"),
                onChanged: (bool) {},
                value: true,
                activeColor: UI.primaryColor,
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Name container",
                        style: TextStyle(
                            color: UI.textColor.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                  ListTile(
                    leading: Icon(
                      Icons.notifications,
                      size: 30,
                    ),
                    title: Text("Data",style: TextStyle(
                      color: UI.textColor,
                      fontSize: 14,
                    ),),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.exit_to_app,
                      size: 30,
                    ),
                    title: Text("Data",style: TextStyle(
                      color: UI.textColor,
                      fontSize: 14,
                    ),),
                    onTap: (){
                      context.bloc<AuthBloc>().add(LogoutAuthEvent());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
