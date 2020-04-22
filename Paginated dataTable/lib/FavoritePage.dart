import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<User> users;
  List<User> selectedUsers;
  bool sort;
  @override
  void initState() {
    super.initState();
    sort = false;
    selectedUsers = [];
    users = User.getUsers();
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        users.sort((a, b) => a.firstname.compareTo(b.firstname));
      } else {
        users.sort((a, b) => b.firstname.compareTo(a.firstname));
      }
    }
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 50.0,
          sortAscending: sort,
          sortColumnIndex: 0,
          columns: [
            DataColumn(
              numeric: true,
              label: Text("firstname"),
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSortColumn(columnIndex, ascending);
              },
              tooltip: "This is a Firstname",
              
            ),
            DataColumn(
              numeric: true,
              label: Text("lastname"),
              tooltip: "This is a Lastname",
            ),
            DataColumn(
              numeric: true,
              label: Center(child: Text("Delete")),
              tooltip: "This is a Lastname",
            ),
          ],
          rows: users
              .map(
                (user) => DataRow(
                    selected: selectedUsers.contains(user),
                    onSelectChanged: (b) {
                      onSelectedRow(b, user);
                    },
                    cells: [
                      DataCell(Text(user.firstname), onTap: () {
                        print("selected user ${user.firstname}");
                      }),
                      DataCell(Text(user.lastname), onTap: () {
                        print("selected user ${user.lastname}");
                      }),
                      DataCell(Icon(Icons.delete_outline,color:Colors.black), onTap: () {
                        setState(() {
                          users.remove(user);
                        });
                      }),
                    ]),
              )
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            child: dataBody(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: OutlineButton(
                  onPressed: () {},
                  child: Text("Selected ${selectedUsers.length}"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: OutlineButton(
                  onPressed: selectedUsers.isEmpty
                      ? null
                      : () {
                          setState(() {
                            deleteSelected();
                          });
                        },
                  child: Text("Delete Selected"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onSelectedRow(bool selected, User user) {
    setState(() {
      if (selected) {
        selectedUsers.add(user);
      } else {
        selectedUsers.remove(user);
      }
    });
  }

  void deleteSelected() {
    if (selectedUsers.isNotEmpty) {
      List<User> temp = [];
      temp.addAll(selectedUsers);
      for (User user in temp) {
        users.remove(user);
        selectedUsers.remove(user);
      }
    }
  }
}

class User {
  String firstname;
  String lastname;
  User({this.firstname, this.lastname});

  static List<User> getUsers() {
    return <User>[
      User(firstname: "sunil", lastname: "shedge"),
      User(firstname: "Akash", lastname: "shedge"),
      User(firstname: "Prasad", lastname: "Jadhav"),
      User(firstname: "Shubham", lastname: "kadam"),
      User(firstname: "Vishal", lastname: "jadhav"),
      User(firstname: "Rohit", lastname: "Phadtare"),
      User(firstname: "rushikant", lastname: "Shitole"),
      User(firstname: "Sangram", lastname: "Alde"),
    ];
  }
}
