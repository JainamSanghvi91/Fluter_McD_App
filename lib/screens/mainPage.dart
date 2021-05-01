import 'dart:math';
import 'package:McD/provider/p_category.dart';
import 'package:McD/screens/analytics.dart';
import 'package:McD/screens/products.dart';
import 'package:McD/utility/app_string.dart';
import 'package:McD/utility/size_config.dart';
import 'package:McD/utility/styling.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String search;

  void allotingserach(String searchstring) {
    print("search is $searchstring");
    setState(() {
      search = searchstring;
    });
  }

  List<Map<String, Object>> _pages;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      {'page': Products(), 'title': AString.products},
      {'page': Analytics(), 'title': AString.analytics},
    ];
  }

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final category = Provider.of<P_Category>(context).allcategory();
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            SizeConfig().init(constraints);
            /*print("Menu");
            print("Menu height is ${constraints.maxHeight}");
            print("Menu width is ${constraints.maxWidth}");
            print(
                "Menu height using sizeconfig is ${SizeConfig.heightMultiplier * 100}");*/
            var maxH = max(constraints.maxHeight, 710);
            var maxW =
                max(constraints.maxWidth, SizeConfig.widthMultiplier * 100);
            //print("MaxH- ${maxH}");
            return Column(
              children: [
                // Expanded(
                //   flex: 1,
                //   child:
                Container(
                  width: maxW,
                  height: maxH / 12,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey[350],
                        offset: Offset(0.0046 * maxH, 0.0046 * maxH),
                        blurRadius: 0.0046 * maxH)
                  ]),
                  padding: EdgeInsets.only(top: 15),
                  child: Center(
                    child: Text(
                      "McDonald's Dashboard",
                      style: TextStyle(
                        color: Colors.red[900],
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                // ),
                Expanded(
                  // flex: 10,
                  child: _pages[_selectedPageIndex]['page'],
                ),
                // Expanded(
                //   flex: 1,
                // child:
                Container(
                    height: maxH / 12,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0.00309 * maxH),
                    child: BottomNavigationBar(
                      s: _selectedPageIndex,
                      changeselected: _selectPage,
                    )),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BottomNavigationBar extends StatelessWidget {
  final Function changeselected;
  final int s;
  const BottomNavigationBar({
    Key key,
    this.s,
    this.changeselected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        /*print("Bottom navigation ");
        print("height is ${constraints.maxHeight}");
        print("width is ${constraints.maxWidth}");
*/
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => this.changeselected(0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Divider(
                          height: 0.09 * constraints.maxHeight,
                          thickness: 0.011 * constraints.maxWidth,
                          color:
                              this.s == 0 ? Colors.red[900] : Colors.grey[100]),
                    ),
                    Expanded(
                      child: Icon(
                        Icons.store,
                        color: this.s == 0 ? Colors.red[900] : Colors.grey,
                      ),
                    ),
                    Text(
                      AString.products,
                      style: TextStyle(
                          color: this.s == 0 ? Colors.red[900] : Colors.grey,
                          fontSize: 0.27 * constraints.maxHeight,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => this.changeselected(1),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Divider(
                          height: 0.09 * constraints.maxHeight,
                          thickness: 0.011 * constraints.maxWidth,
                          color:
                              this.s == 1 ? Colors.red[900] : Colors.grey[100]),
                    ),
                    Expanded(
                      child: Icon(
                        Icons.analytics,
                        color: this.s == 1 ? Colors.red[900] : Colors.grey,
                      ),
                    ),
                    Text(
                      AString.analytics,
                      style: TextStyle(
                          color: this.s == 1 ? Colors.red[900] : Colors.grey,
                          fontSize: 0.27 * constraints.maxHeight,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// class AllProducts extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var maxH = SizeConfig.heightMultiplier * 100;
//     var maxW = SizeConfig.widthMultiplier * 100;
//     return Column(
//       children: [
//         Expanded(
//           flex: 3,
//           child: Column(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(bottom: 1),
//                       decoration: BoxDecoration(
//                           border: Border(
//                               bottom: BorderSide(
//                                   color: AppTheme.bottomnavigationactive,
//                                   width: maxW * 0.009))),
//                       child: Text(
//                         "McD",
//                         style: TextStyle(
//                             fontSize: 26, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Column(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Padding(
//                         padding: EdgeInsets.only(left: maxW * 0.012),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Bina Provision Store",
//                             style: TextStyle(
//                                 fontSize: 19, fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 5,
//                       child: Consumer<P_Category>(
//                         builder: (ctx, category, _) => ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (context, index) {
//                             return InkWell(
//                               onTap: () =>
//                                   {}, //Navigator.of(context).pushNamed(ParticularShop.routename),
//                               child: Container(
//                                 margin: EdgeInsets.only(
//                                     bottom: maxH * 0.024, top: maxH * 0.014),
//                                 padding: EdgeInsets.only(
//                                     top: maxH * 0.014,
//                                     bottom: maxH * 0.024,
//                                     left: maxW * 0.014,
//                                     right: maxW * 0.014),
//                                 decoration: BoxDecoration(
//                                   border: Border(
//                                     right: BorderSide(
//                                         width: maxW * 0.0025,
//                                         color: Colors.grey[400]),
//                                   ),
//                                 ),
//                                 child: Flexible(
//                                   flex: 7,
//                                   child: Center(
//                                     child: Text(
//                                       "jainam", //category.items[index].categoryName,
//                                       maxLines: 2,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 13),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                           itemCount: category.items.length,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
