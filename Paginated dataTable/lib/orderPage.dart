import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<User> users;
  int columnIndex = 0;
  List<User> selectedUser;
  var data;
   int sortColumnIndex=0;
  bool sortAscending = true;
  int rowPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  void initState() {
    super.initState();
    data = Data();
    selectedUser = [];
    users = User.getUsers();
   
  }
@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (data == null) {
      data = new Data();
    }
  }
  


 void sort(
      Comparable getField(User d), int columnIndex, bool ascending) {
    data.sort(getField, ascending);
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: PaginatedDataTable(
                  columnSpacing: 1080,
                  sortAscending: sortAscending,
                  sortColumnIndex: sortColumnIndex,
                  onSelectAll: data.selectAll,
                  actions: <Widget>[],
                  onRowsPerPageChanged: (r) {
                    setState(() {
                      rowPerPage = r;
                    });
                  },
                  rowsPerPage: rowPerPage,

                  header: Center(child: Text("DataTable")),
                  columns: [
                    DataColumn(
                        tooltip: "This is Firstname",
                         onSort: (columnIndex, ascending) =>
                    sort((d) => d.firstname, columnIndex, ascending),
                          
                        label: Text("Firstname")),
                    DataColumn(
                        tooltip: "This is Lastname",
                        label: Text("Lastname")),
                  ],
                  source: data),
            ),
          ],
        ),
      ),
    );
  }
}

class Data extends DataTableSource {
  List<User> users = User.getUsers();
  User user;
  List<User> selectedUser = [];

  
  int selectedCount = 0;
  

 void sort<T>(Comparable<T> getField(User d), bool ascending) {
    users.sort((a, b) {
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }
  @override
  DataRow getRow(int index) {

    assert(index >= 0);
    if (index >= users.length) return null;
    final User user = users[index];
   
    return DataRow.byIndex(
        index: index,
         selected: user.selected,
        onSelectChanged: (value) {
        if (user.selected != value) {
          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          user.selected = value;
          notifyListeners();
        }
      },
        cells: [
          DataCell(Text(user.firstname)),
          DataCell(Text(user.lastname)),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => selectedCount;

  void selectAll(bool checked) {
    for (final User user in users) {
      user.selected = checked;
    }
    selectedCount = checked ? users.length : 0;
    notifyListeners();
  }
}

class User {
  String firstname;
  String lastname;
  bool selected = false;
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
      User(firstname: "Sanket", lastname: "shinde"),
      User(firstname: "Akash", lastname: "Jadhav"),
      User(firstname: "sangram", lastname: "Shinde"),
      User(firstname: "Anil", lastname: "Shinde"),
      User(firstname: "Omkar", lastname: "Kadam"),
      User(firstname: "sangram", lastname: "Shinde"),
      User(firstname: "sunil", lastname: "Shinde"),
      User(firstname: "sumit", lastname: "Jadhav"),
      User(firstname: "Rohit", lastname: "Pawar"),
      User(firstname: "Rushikant", lastname: "Shinde"),
      User(firstname: "Sanket", lastname: "shinde"),
      User(firstname: "Akash", lastname: "Jadhav"),
    ];
  }
}
