import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/src/models/user_model.dart';
import 'package:realtime_chat/src/services/auth_service.dart';
import 'package:realtime_chat/src/services/chat_service.dart';
import 'package:realtime_chat/src/services/socket_service.dart';
import 'package:realtime_chat/src/services/users_service.dart';
import 'package:realtime_chat/src/widgets/chat_message_widget.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final userService = UserService();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);


  List<User> users = [];

  @override
  void initState() {
    // TODO: implement initState
    this._loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final user = authService.user;
    print(socketService.serverStatus);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            user.name,
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            onPressed: () {
              //TODO desconectar del socket server
              socketService.disconnect();
              AuthService.deleteToken();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: (socketService.serverStatus == ServerStatus.Online)
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                    )
                  : Icon(
                      Icons.check_circle,
                      color: Colors.redAccent,
                    ),
            )
          ],
        ),
        body: SmartRefresher(
          onRefresh: _loadUsers,
          controller: _refreshController,
          child: _renderUsersListView(),
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue,
            ),
            waterDropColor: Colors.blue,
          ),
          enablePullDown: true,
        ));
  }

  Widget _renderListTile(User user) {
    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onTap: (){
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userFor = user;
        Navigator.pushNamed(context, '/chat');
      },
    );
  }

  Widget _renderUsersListView() {
    return ListView.separated(
      separatorBuilder: (_, i) => Divider(),
      itemCount: this.users.length,
      itemBuilder: (context, index) {
        User user = users[index];
        return _renderListTile(user);
      },
    );
  }

  _loadUsers() async {


    this.users = await this.userService.getUsers();
    setState(() {});
    // await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
