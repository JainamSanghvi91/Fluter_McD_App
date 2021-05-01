import 'dart:math';

import 'package:McD/models/item.dart';
import 'package:McD/provider/p_category.dart';
import 'package:McD/provider/p_items.dart';
import 'package:McD/utility/size_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool initial = true;
  bool isLoading = false;
  bool initalerror = true;
  List<Items> itemlist = [];

  int _selected = 0;
  void _selectPage(int index) {
    setState(() {
      _selected = index;
    });
  }

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (initial) {
      setState(() {
        isLoading = true;
      });
      Provider.of<P_Category>(context, listen: false)
          .fetchcategory()
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
      Provider.of<P_Items>(context, listen: false).fetchItems().then((value) {
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

  String search;

  void allotingserach(String searchstring) {
    print("search is $searchstring");
    setState(() {
      search = searchstring;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool selected = false;
        SizeConfig().init(constraints);
        print("Inside home Page");
        print("height is ${constraints.maxHeight}");
        print("width is ${constraints.maxWidth}");
        var maxH =
            max(SizeConfig.heightMultiplier * 100, constraints.maxHeight);
        return Column(
          children: [
            // Expanded(
            //   flex: 2,
            //   child:
            Container(
              //height: maxH / 10,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    border: new Border.all(
                      color: Colors.black,
                    )),
                child: SearchBar(allotSearch: allotingserach),
              ),
            ),
            //),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey)]),
              //height: maxH / 10,
              height: 60,
              child: Consumer<P_Category>(
                builder: (context, category, _) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        _selectPage(index);
                        itemlist = Provider.of<P_Items>(context, listen: false)
                            .findBycategoryId(index);
                        print("here");
                        print(itemlist.length);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        color: index == _selected ? Colors.amber : Colors.white,
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        // child: Flexible(
                        //   flex: 7,
                        child: Center(
                          child: Text(
                            category.items[index].categoryName,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: index == _selected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                fontSize: index == _selected ? 16 : 13),
                          ),
                        ),
                      ),
                      //),
                    );
                  },
                  itemCount: category.items.length,
                ),
              ),
            ),
            Expanded(
              //flex: 16,
              child:
                  //  Consumer<P_Items>(
                  //   builder: (context, it, _) =>
                  ListView.builder(
                itemBuilder: (context, index) {
                  print(itemlist.length);
                  return InkWell(
                    onTap: () {},
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Text(
                                              itemlist[index].itemName,
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
                                      Flexible(
                                        flex: 1,
                                        child: Text(
                                          "Rs. " +
                                              itemlist[index].price.toString(),
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
                itemCount: itemlist.length,
              ),
            ),
          ],
        );
      },
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key key,
    @required this.allotSearch,
  }) : super(key: key);

  final Function allotSearch;
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  FocusNode searchFocusNode;
  bool isSearch = false;
  final searchcontorller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    searchFocusNode.dispose();
    searchcontorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isSearch
            ? Container(
                color: Colors.transparent,
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    isSearch = !isSearch;
                  });
                  searchFocusNode.requestFocus();
                },
                child: Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
        Expanded(
          child: isSearch
              ? Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (searchcontorller.text == "") {
                          setState(() {
                            isSearch = false;
                          });
                          widget.allotSearch("");
                        } else {
                          widget.allotSearch(searchcontorller.text);
                        }
                        searchFocusNode.unfocus();
                      },
                      child: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          //hintText: "Search for your location...",
                        ),
                        controller: searchcontorller,
                        focusNode: searchFocusNode,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        onSubmitted: (value) {
                          if (value == "") {
                            setState(() {
                              isSearch = false;
                            });
                            widget.allotSearch("");
                          } else {
                            widget.allotSearch(value);
                          }
                        },
                      ),
                    ),
                  ],
                )
              : TextField(
                  decoration: InputDecoration.collapsed(
                    //isDense: true,
                    hintText: "Search for your location...",
                  ),
                  controller: searchcontorller,
                  focusNode: searchFocusNode,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  onSubmitted: (value) {
                    if (value == "") {
                      setState(() {
                        isSearch = false;
                      });
                      widget.allotSearch("");
                    } else {
                      widget.allotSearch(value);
                    }
                  },
                ),
        ),
      ],
    );
  }
}
