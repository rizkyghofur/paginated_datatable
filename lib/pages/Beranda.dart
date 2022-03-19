import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key key}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  final DataDummy _data = DataDummy();

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  void _sort<T>(Comparable<T> Function(Dessert d) getField, int columnIndex,
      bool ascending) {
    _data._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataTable Pagination'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          PaginatedDataTable(
            source: _data,
            header: const Text('Daftar Produk'),
            columns: [
              DataColumn(
                  label: const Text('ID'),
                  onSort: (int columnIndex, bool ascending) =>
                      _sort<num>((Dessert d) => d.id, columnIndex, ascending)),
              DataColumn(
                  label: Text('Name'),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                      (Dessert d) => d.title, columnIndex, ascending)),
              DataColumn(
                  label: Text('Price'),
                  onSort: (int columnIndex, bool ascending) => _sort<num>(
                      (Dessert d) => d.price, columnIndex, ascending)),
              DataColumn(
                  label: Text('Desc'),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                      (Dessert d) => d.desc, columnIndex, ascending))
            ],
            columnSpacing: 100,
            horizontalMargin: 10,
            rowsPerPage: 4,
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            showCheckboxColumn: false,
          ),
        ],
      ),
    );
  }
}

class Dessert {
  Dessert(this.id, this.title, this.price, this.desc);
  final int id;
  final String title;
  final double price;
  final String desc;

  bool selected = false;
}

class DataDummy extends DataTableSource {
  final List<Dessert> _data = <Dessert>[
    Dessert(1, 'taest', 20, 'no desc'),
    Dessert(2, 'tesasst', 21, 'no desc'),
    Dessert(3, 'astest', 22, 'no desc'),
    Dessert(4, 'retest', 23, 'no desc'),
    Dessert(5, 'fdsfstest', 24, 'no desc'),
    Dessert(6, 'eretest', 25, 'no desc'),
    Dessert(7, 'rytest', 26, 'no desc'),
    Dessert(8, 'rtrtest', 27, 'no desc'),
    Dessert(9, 'aetest', 28, 'no desc'),
    Dessert(10, 'ghtest', 29, 'no desc'),
  ];

  void _sort<T>(Comparable<T> Function(Dessert d) getField, bool ascending) {
    _data.sort((Dessert a, Dessert b) {
      if (!ascending) {
        final Dessert c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    final Dessert data = _data[index];
    return DataRow(cells: [
      DataCell(Text(data.id.toString()), onTap: () {
        print(data.title);
      }),
      DataCell(Text(data.title)),
      DataCell(Text(data.price.toString())),
      DataCell(Text(data.desc)),
    ]);
  }
}
