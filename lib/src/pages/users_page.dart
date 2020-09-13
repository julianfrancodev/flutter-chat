import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/src/models/user_model.dart';
import 'package:realtime_chat/src/services/auth_service.dart';
import 'package:realtime_chat/src/widgets/chat_message_widget.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final List<User> users = [
    new User(online: true, name: 'Maria', email: "maria@email.com", uid: '1'),
    new User(online: true, name: 'Juan', email: "juan@email.com", uid: '2'),
    new User(online: true, name: 'Carlos', email: "carlos@email.com", uid: '3'),
    new User(online: false, name: 'Pedro', email: "pedro@email.com", uid: '4'),
    new User(
        online: true, name: 'Caterine', email: "caterine@email.com", uid: '5'),
  ];

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

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

            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.check_circle,
              color: Colors.blue,
            ),
          )
        ],
      ),
      body: SmartRefresher(
        onRefresh: _loadUsers,
        controller: _refreshController,
        child: _renderUsersListView(),
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue,),
          waterDropColor: Colors.blue,
        ),
        enablePullDown: true,
      )
    );
  }

  Widget _renderListTile(User user){
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
    );
  }

  Widget _renderUsersListView(){
    return  ListView.separated(
      separatorBuilder: (_, i) => Divider(),
      itemCount: this.users.length,
      itemBuilder: (context, index) {
        User user = users[index];
        return _renderListTile(user);
      },
    );
  }

  _loadUsers() async{
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();

  }


}
