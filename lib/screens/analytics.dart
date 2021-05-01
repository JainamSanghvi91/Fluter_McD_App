import 'package:McD/models/customer.dart';
import 'package:McD/models/item.dart';
import 'package:McD/models/orders.dart';
import 'package:McD/provider/p_customer.dart';
import 'package:McD/provider/p_items.dart';
import 'package:McD/provider/p_orders.dart';
import 'package:McD/utility/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  bool initial = true;
  bool isLoading = false;
  bool initalerror = true;
  List<Customer> customerlist = [];
  List<Items> itemslist = [];
  List<Orders> orderslist = [];

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (initial) {
      setState(() {
        isLoading = true;
      });
      Provider.of<P_Customer>(context, listen: false)
          .fetchcustomer()
          .then((value) {
        initial = false;
        setState(() {
          isLoading = false;
        });
      }).catchError((onError) {
        if (initalerror) {
          setState(() {
            isLoading = false;
          });
          print(onError);
          print("Something went wrong,try again");
          print("not able to fetch");
        }
        initalerror = false;
      });
    }
    if (initial) {
      setState(() {
        isLoading = true;
      });
      Provider.of<P_Orders>(context, listen: false).fetchOrders().then((value) {
        initial = false;
        setState(() {
          isLoading = false;
        });
      }).catchError((onError) {
        if (initalerror) {
          setState(() {
            isLoading = false;
          });
          print(onError);
          print("Something went wrong,try again");
          print("not able to fetch");
        }
        initalerror = false;
      });
    }
  }

  var _dateTime;
  int _selectedIndex = 0;
  int _selected = 0;
  void _selectPage(int index) {
    setState(() {
      _selected = 0;
      _selectedIndex = index;
    });
  }

  void _selectfilter(int index) {
    setState(() {
      _selected = index;
    });
  }

  void _filtercustomers(int i) {
    setState(() {
      customerlist =
          Provider.of<P_Customer>(context, listen: false).findByvegfilter(i);
      print("filter");
      print(customerlist.length);
    });
  }

  void _filteritems(int i) {
    setState(() {
      itemslist =
          Provider.of<P_Items>(context, listen: false).findByvegfilter(i);
      print("filter");
      print(itemslist.length);
    });
  }

  void _filterorders(int i) {
    setState(() {
      orderslist =
          Provider.of<P_Orders>(context, listen: false).findByvegfilter(i);

      print("filter");
      print(orderslist.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      SizeConfig().init(constraints);
      print("Inside home Page");
      print("height is ${constraints.maxHeight}");
      print("width is ${constraints.maxWidth}");
      return Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => _selectPage(0),
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 0
                          ? Colors.yellow[600]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    child: Text("View Orders"),
                  ),
                ),
                InkWell(
                  onTap: () => _selectPage(1),
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        color: _selectedIndex == 1
                            ? Colors.yellow[600]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.black)),
                    child: Text("View Sales"),
                  ),
                ),
                InkWell(
                  onTap: () => _selectPage(2),
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        color: _selectedIndex == 2
                            ? Colors.yellow[600]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.black)),
                    child: Text("View Customers"),
                  ),
                ),
              ],
            ),
          ),
          _selectedIndex == 0
              ? Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Flexible(
                          child: Text(
                            "Filters",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _selectfilter(0);
                          _filterorders(0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: _selected == 0 && _selectedIndex == 0
                                    ? Colors.red[700]
                                    : Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Flexible(
                            child: Text(
                              "Date",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _selectfilter(1);
                          _filterorders(1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: _selected == 1 && _selectedIndex == 0
                                    ? Colors.red[700]
                                    : Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Flexible(
                            child: Text(
                              "Veg Order",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _selectfilter(2);
                          _filterorders(2);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: _selected == 2 && _selectedIndex == 0
                                    ? Colors.red[700]
                                    : Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Flexible(
                            child: Text(
                              "Non-Veg Order",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : _selectedIndex == 1
                  ? Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Flexible(
                              child: Text(
                                "Filters",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _selectfilter(0);
                              _filteritems(0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: _selected == 0 && _selectedIndex == 1
                                        ? Colors.red[700]
                                        : Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Flexible(
                                child: Text(
                                  "Vegetarian",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _selectfilter(1);
                              _filteritems(1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: _selected == 1 && _selectedIndex == 1
                                        ? Colors.red[700]
                                        : Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Flexible(
                                child: Text(
                                  "Non-Vegetarian",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Flexible(
                              child: Text(
                                "Filters",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _selectfilter(0);
                              _filtercustomers(0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: _selected == 0 && _selectedIndex == 2
                                        ? Colors.red[700]
                                        : Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Flexible(
                                child: Text(
                                  "Vegetarian",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _selectfilter(1);
                              _filtercustomers(1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: _selected == 1 && _selectedIndex == 2
                                        ? Colors.red[700]
                                        : Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Flexible(
                                child: Text(
                                  "Non-Vegetarian",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
          Expanded(
            flex: 1,
            child: _selected == 0 && _selectedIndex == 0
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Date - "),
                        Text(_dateTime == null
                            ? 'Click here to select the date'
                            : _dateTime.toString()),
                        RaisedButton(
                          child: Text('Pick a date'),
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: _dateTime == null
                                        ? DateTime.now()
                                        : _dateTime,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2022))
                                .then((date) {
                              setState(() {
                                _dateTime = date;
                              });
                            });
                          },
                        )
                      ],
                    ),
                  )
                : _selected == 1 && _selectedIndex == 0
                    ? Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("Total Orders: 200"),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text("Vegetarian Orders: 200"),
                          )
                        ],
                      )
                    : _selected == 2 && _selectedIndex == 0
                        ? Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("Total Orders: 200"),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("Non-Vegetarian Orders: 200"),
                              )
                            ],
                          )
                        : _selected == 0 && _selectedIndex == 1
                            ? Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text("Total Products: 200"),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("Vegetarian Products: 200"),
                                  )
                                ],
                              )
                            : _selected == 1 && _selectedIndex == 1
                                ? Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text("Total Products: 200"),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                            "Non-Vegetarian Products: 200"),
                                      )
                                    ],
                                  )
                                : _selected == 0 && _selectedIndex == 2
                                    ? Column(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text("Total Customers: 200"),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                                "Vegetarian Customers: 200"),
                                          )
                                        ],
                                      )
                                    : _selected == 1 && _selectedIndex == 2
                                        ? Column(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                    "Total Customers: 200"),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                    "Non-Vegetarian Customers: 200"),
                                              )
                                            ],
                                          )
                                        : Container(),
          ),
          Expanded(
            flex: 7,
            child: _selectedIndex == 0
                ? OrdersScreen(orderslist: orderslist)
                : _selectedIndex == 1
                    ? Sales(itemslist: itemslist)
                    : Customers(
                        customerlist: customerlist,
                      ),
          ),
        ],
      );
    });
  }
}

class OrdersScreen extends StatelessWidget {
  List<Orders> orderslist;
  OrdersScreen({@required this.orderslist});
  @override
  Widget build(BuildContext context) {
    return
        // Consumer<P_Orders>(
        //   builder: (context, orders, _) =>
        ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => {},
          child: Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            padding: EdgeInsets.only(top: 4, left: 4, right: 4),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(top: 6, left: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Text(
                                orderslist[index].name,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                "Date - " +
                                    orderslist[index].date.substring(0, 10),
                                maxLines: 2,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                "Rs. " + orderslist[index].total.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[600],
                )
              ],
            ),
          ),
        );
      },
      itemCount: orderslist.length,
      //),
    );
  }
}

class Sales extends StatelessWidget {
  List<Items> itemslist;
  Sales({@required this.itemslist});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => {},
          child: Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            padding: EdgeInsets.only(top: 4, left: 4, right: 4),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        width: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              'https://st.depositphotos.com/1102480/1589/i/950/depositphotos_15890699-stock-photo-big-hamburger.jpg',
                              fit: BoxFit.fill,
                            )),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0)),
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(top: 6, left: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    itemslist[index].itemName,
                                    //"Burger ",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                ),
                                Image.asset(
                                  'lib/assets/images/non-veg.png',
                                  fit: BoxFit.fill,
                                  scale: 2.2,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                "This is a delicious burger and is very tasty to eat. Also, this is very much selling product of our store.",
                                maxLines: 2,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    "Rs. " + itemslist[index].price.toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    width: 60,
                                    margin: EdgeInsets.only(right: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[600],
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Center(child: Text("20")),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[600],
                )
              ],
            ),
          ),
        );
      },
      itemCount: itemslist.length,
    );
  }
}

class Customers extends StatefulWidget {
  List<Customer> customerlist;
  Customers({@required this.customerlist});

  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  @override
  Widget build(BuildContext context) {
    return
        // Consumer<P_Customer>(
        //   builder: (context, customer, _) =>
        ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => {},
          child: Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            padding: EdgeInsets.only(top: 4, left: 4, right: 4),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        width: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              'https://st.depositphotos.com/1102480/1589/i/950/depositphotos_15890699-stock-photo-big-hamburger.jpg',
                              fit: BoxFit.fill,
                            )),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0)),
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(top: 6, left: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Text(
                                widget.customerlist[index].name,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                widget.customerlist[index].phone,
                                maxLines: 2,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[600],
                )
              ],
            ),
          ),
        );
      },
      itemCount: widget.customerlist.length,
      // ),
    );
  }
}
