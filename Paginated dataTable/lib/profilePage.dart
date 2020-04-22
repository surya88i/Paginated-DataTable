import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
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
class _ProfilePageState extends State<ProfilePage> {
  var dataSource=DataSource();
  bool sort=false;
  int rowPerPage=PaginatedDataTable.defaultRowsPerPage;
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              PaginatedDataTable(
                onRowsPerPageChanged: (val){
                  rowPerPage=val;
                },
                rowsPerPage: rowPerPage,
                columnSpacing: 120.0,
                sortAscending: sort,

                sortColumnIndex: 0,
                header: Center(child: Text("Data Table")),
                columns: [
                  DataColumn(label: Text("Firstname"),numeric: true,
                  onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSortColumn(columnIndex, ascending);
              },
                  
                  ),
                  DataColumn(label: Text("Lastname"),numeric: true),
                ],
                source: dataSource,
                ),
            ],
          ),
        ),
      );
    }
  }
  
  class DataSource extends DataTableSource{
  @override
  DataRow getRow(int index) {
     users=<User>[
      User(firstname: "Sunil",lastname:"Shinde"),
      User(firstname: "Akshay",lastname:"Kadam"),
      User(firstname: "Amar",lastname:"Kadam"),
      User(firstname: "Sammer",lastname:"Thorat"),
      User(firstname: "Adarsh",lastname:"Shukla"),
      User(firstname: "Rushikesh",lastname:"Shinde"),
      User(firstname: "Ramesh",lastname:"Yadav"),
      User(firstname: "Ram",lastname:"Shinde"),
      User(firstname: "Adinath",lastname:"Shinde"),
      User(firstname: "Sangram",lastname:"Shinde"),
      User(firstname: "Sunil",lastname:"Shedge"),
    ];
    assert(index >=0);
    if(index >=users.length) return null;
    final User user=users[index];
   
    return DataRow.byIndex(
      index: index,
      cells: [
      DataCell(Text(user.firstname)),
      DataCell(Text(user.lastname)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount =>10;

  @override
  int get selectedRowCount => 0;
}
class User{
  final String firstname;
  final String lastname;
  User({this.firstname,this.lastname});
}
List<User> users;
