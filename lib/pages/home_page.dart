import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_chat/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc_chat/blocs/message_bloc/message_bloc.dart';
import 'package:flutter_bloc_chat/config/routes.dart';
import 'package:flutter_bloc_chat/models/conversation.dart';
import 'package:flutter_bloc_chat/providers/auth_provider.dart';
import 'package:flutter_bloc_chat/utils/shared_pres.dart';
import 'package:flutter_bloc_chat/widgets/conversation_item.dart';
import '../models/message.dart';
import '../providers/message_provider.dart';
import '../blocs/chat_bloc/chat_bloc.dart';
import '../blocs/conversation_bloc/conversation_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      print(_tabController.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: TabBarView(
          controller: _tabController,
          children: [
            ConversationsList(),
            ContactsList(),
            Setting(),
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
                icon: Icon(Icons.contact_page),
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
      ),
    );
  }
}

class ConversationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
        builder: (context, state) {
      if (state is ConversationSuccess) {
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.list.length,
            itemBuilder: (builder, index) {
              return ConversationItem(state.list[index]);
            });
      }
      return Container();
    });
  }
}

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
