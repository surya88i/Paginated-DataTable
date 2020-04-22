import 'package:flutter/material.dart';
import 'package:footer/FavoritePage.dart';
import 'orderPage.dart';
import 'package:footer/profilePage.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget currentPage;
  List<Widget> pages;
  int currentIndex = 0;
  HomePage homePage;
  OrderPage orderPage;
  FavoritePage favoritePage;
  ProfilePage profilePage;
  @override
  void initState() {
    super.initState();
    homePage = HomePage();
    orderPage = OrderPage();
    favoritePage = FavoritePage();
    profilePage = ProfilePage();
    pages = [homePage, orderPage, favoritePage, profilePage];
    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bottom Navigation Bar",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = pages[currentIndex];
          });
        },
        items: [
          BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text("Order"), icon: Icon(Icons.shop_two)),
          BottomNavigationBarItem(
              title: Text("Favourite"), icon: Icon(Icons.favorite_border)),
          BottomNavigationBarItem(
              title: Text("Profile"), icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users;
  List<User> selectedUser;
  bool sort;
  @override
  void initState() {
    super.initState();
    users = User.getUsers();
    selectedUser = [];
    sort = false;
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          sortColumnIndex: 0,
          sortAscending: sort,   
          columnSpacing: MediaQuery.of(context).size.width / 2,
          columns: [
            DataColumn(
                //numeric: true,
                onSort: (columnIndex, ascending) {
                  setState(() {
                    sort = !sort;
                  });
                  onSort(columnIndex, ascending);
                },
                tooltip: "this is Firstname",
                label: Text("Firstname")),
            DataColumn(
                //numeric: true,
                tooltip: "this is Lastname",
                label: Text("Lastname"))
          ],
          rows: users
              .map((user) => DataRow(
                      selected: selectedUser.contains(user),
                      onSelectChanged: (selected) {
                        onSelectedRow(selected, user);
                      },
                      cells: [
                        DataCell(Text(user.firstname)),
                        DataCell(Text(user.lastname)),
                      ]))
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(child: Center(child: dataBody())),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  setState(() {
                    if (selectedUser.isEmpty) {
                      selectedUser.addAll(users);
                    }
                  });
                },
                child: Text("SELECTED ${selectedUser.length}"),
              ),
              OutlineButton(
                onPressed: () {
                  deleteSelected();
                },
                child: Text("Delete Selected"),
              )
            ],
          ),
        ],
      ),
    );
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        users.sort((a, b) => a.firstname.compareTo(b.firstname));
      } else {
        users.sort((a, b) => b.firstname.compareTo(a.firstname));
      }
    }
  }

  void onSelectedRow(bool selected, User user) {
    setState(() {
      if (selected) {
        selectedUser.add(user);
      } else {
        selectedUser.remove(user);
      }
    });
  }

  void deleteSelected() {
    setState(() {
      List<User> temp = [];
      temp.addAll(selectedUser);
      for (User user in temp) {
        users.remove(user);
        selectedUser.remove(user);
      }
    });
  }
}



class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class User {
  String firstname;
  String lastname;
  User({this.firstname, this.lastname});

  static List<User> getUsers() {
    return <User>[
      User(firstname: "sangram", lastname: "Shinde"),
      User(firstname: "Anil", lastname: "Shinde"),
      User(firstname: "Omkar", lastname: "Kadam"),
      User(firstname: "sangram", lastname: "Shinde"),
      User(firstname: "sunil", lastname: "Shinde"),
      User(firstname: "sumit", lastname: "Jadhav"),
      User(firstname: "Rohit", lastname: "Pawar"),
      User(firstname: "Rushikant", lastname: "Shinde"),
      User(firstname: "Sanket", lastname: "shinde")
    ];
  }
}
