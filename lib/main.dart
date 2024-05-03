import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final ScrollController _scrollContainer = ScrollController();
  List<GlobalKey> _colorOptionKeyList = [];
  String? _selectedModel;
  int? _selectedColor;
  int? _selectedShoeSize;
  int _descriptionMaxLines = 4;

  @override
  void initState() {
    _selectedModel = 'NikeAirforce_1s_BrownTan.glb';
    WidgetsBinding.instance.addPostFrameCallback((_){
      // make request to view colors
      for (int i = 0; i < 5; i++) {
        GlobalKey _key = GlobalKey(debugLabel: i.toString());
        if (i == 0) {
          if (kDebugMode) {
            print('[-] Set _selectedColor => _key ($_key)');
          }
          _selectedColor = i;//_key;
        }
        _colorOptionKeyList.add(_key);
      }
      setState(() => {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
        appBar: AppBar(
          title: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      print('[-] BACK button pressed');
                    }
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xfffefefe),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 3,
                          color: Color(0xffe6e6e6)
                        )
                      ]
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 22,
                      color: Color(0xFF131313)
                    ),
                  ),
                )
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/logos/DripLogo-purple.png',
                  height: 50
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      print('[-] FAVORITE button pressed');
                    }
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xfffefefe),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 3,
                          color: Color(0xffe6e6e6)
                        )
                      ]
                    ),
                    child: const Icon(
                      Icons.favorite_outline_outlined,
                      size: 22,
                      color: Color(0xFF131313)
                    ),
                  ),
                )
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
        ),
        bottomSheet: Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0xFF212121),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
            )
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15, bottom: 15,
              left: 25, right: 25
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      // price label
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          color: Color(0xff8c8c8c)
                        )
                      ),
                  
                      // price
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          '\$115',
                          style: TextStyle(
                            fontSize: 26,
                            fontFamily: 'PoetsenOne',
                            color: Color(0xFFeeeeee)
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      if (kDebugMode) {
                        print('[-] Checkout button pressed');
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xFF5602ae)
                      ),
                      child: const Center(
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            color: Color(0xFFeeeeee),
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold
                          )
                        ),
                      )
                    ),
                  ),
                )
              ],
            ),
          )
        ),
        body: SingleChildScrollView(
          controller: _scrollContainer,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: ModelViewer(
                    backgroundColor: const Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
                    src: 'assets/3d/$_selectedModel',
                    alt: 'Brown & Tan Nike Airforce 1s',
                    ar: false,
                    // arModes: ['scene-viewer', 'webxr', 'quick-look'],
                    autoRotate: false,
                    iosSrc: 'assets/3d/$_selectedModel',
                    disableZoom: true,
                  ),
                ),
              ),
          
              // body details container 
              Container(
                height: 700,//_detailsBoxHeight,
                width: MediaQuery.of(context).size.width,
                constraints: const BoxConstraints(
                  maxHeight: double.infinity
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFfefefe),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -2),
                      blurRadius: 2,
                      spreadRadius: 3,
                      color: Color(0xffe6e6e6)
                    )
                  ]
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              // start icon
                              Icon(
                                Icons.star_rounded,
                                size: 20,
                                color: Color(0xFFf7d31a),
                              ),
                              // review average
                              Text(
                                '4.8',
                                style: TextStyle(
                                  fontFamily: 'PoetsenOne'
                                )
                              ),
                              // review count
                              Text(
                                '(498)',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 11
                                )
                              ),
                            ],
                          ),
                  
                          // display Text
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Nike Airforce 1',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 32,
                                color: Color(0xFF212121),
                                fontFamily: 'PoetsenOne'
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.topLeft,
                            child: AutoSizeText(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras bibendum nisl non odio ornare fringilla. Aenean ipsum ligula, fermentum nec risus id, iaculis mollis ante. Aliquam interdum libero velit, ac vestibulum urna sodales vel. Duis pulvinar a eros vitae mollis. Morbi porta, nulla non dictum vulputate, lacus urna aliquet ligula, in viverra diam tortor sed ligula. Phasellus ultrices arcu non massa elementum pulvinar. Donec rhoncus, augue id faucibus fermentum, leo nulla laoreet magna, gravida dictum velit eros eu nisi. Ut libero libero, facilisis id ante vitae, rhoncus rutrum nunc. Proin eu blandit mauris, feugiat convallis tellus.',
                              maxLines: _descriptionMaxLines,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF212121),
                                fontFamily: 'Roboto'
                              ),
                              minFontSize: 15,
                              overflowReplacement: Column( // This widget will be replaced. 
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras bibendum nisl non odio ornare fringilla. Aenean ipsum ligula, fermentum nec risus id, iaculis mollis ante. Aliquam interdum libero velit, ac vestibulum urna sodales vel. Duis pulvinar a eros vitae mollis. Morbi porta, nulla non dictum vulputate, lacus urna aliquet ligula, in viverra diam tortor sed ligula. Phasellus ultrices arcu non massa elementum pulvinar. Donec rhoncus, augue id faucibus fermentum, leo nulla laoreet magna, gravida dictum velit eros eu nisi. Ut libero libero, facilisis id ante vitae, rhoncus rutrum nunc. Proin eu blandit mauris, feugiat convallis tellus.',
                                    maxLines: _descriptionMaxLines,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (kDebugMode) {
                                        print('[-] READ MORE clicked');
                                      }
                                      setState(() {
                                        _descriptionMaxLines = _descriptionMaxLines == 4
                                          ? 1000 : 4;
                                      });
                                    },
                                    child: Text(
                                      _descriptionMaxLines == 4
                                      ? 'Read More'
                                      : 'Read Less',
                                      style: const TextStyle(color: Color(0xFF5602ae)),
                                    ),
                                  )
                                ],
                              )
                            ),
                          ), 
                          
                          if (_descriptionMaxLines > 4)
                            Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () {
                                  if (kDebugMode) {
                                    print('[-] READ LESS clicked');
                                  }
                                  setState(() {
                                    _descriptionMaxLines = _descriptionMaxLines == 4
                                      ? 1000 : 4;
                                  });
                                },
                                child: const Text(
                                  'Read Less',
                                  style: TextStyle(color: Color(0xFF5602ae)),
                                ),
                              ) ,
                            ),

                          const Padding(
                            padding: EdgeInsets.only(
                              top: 15, bottom: 10
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Select Color',
                                style: TextStyle(
                                  color: Color(0xFF212121),
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                for (int i=0; i < _colorOptionKeyList.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedColor = i;
                                        });
                                        if (kDebugMode) {
                                          // print('[-] Color: $i Selected');
                                          // print(i == _selectedColor);
                                          // print(_key);
                                          // print(_selectedColor);
                                        }
                                      },
                                      child: Container(
                                        key: _colorOptionKeyList[i],
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(
                                            width: 2,
                                            color: i == _selectedColor
                                              ? Color(0xFF5602ae)
                                              : Color(0xFFeeeeee),
                                          ),
                                          color: Color(0xFFeeeeee),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                              'assets/images/nikeairforce1_browntan.png'
                                            )
                                          ),
                                        ),
                                      )
                                    ),
                                  )
                              ],
                            )
                          ),


                          const Padding(
                            padding: EdgeInsets.only(
                              top: 15, bottom: 10
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Select Size',
                                style: TextStyle(
                                  color: Color(0xFF212121),
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (int i=0; i < 6; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() => _selectedShoeSize = int.parse('4$i'));
                                        if (kDebugMode) {
                                          // print('[-] Color: $i Selected');
                                          // print(i == _selectedColor);
                                          // print(_key);
                                          // print(_selectedColor);
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: _selectedShoeSize == int.parse('4$i')
                                            ? Color(0xFF5602ae)
                                            : Color(0xFFeeeeee),   
                                        ),
                                        child: Center(
                                          child: Text(
                                            '4$i',
                                            style: TextStyle(
                                              color: _selectedShoeSize == int.parse('4$i')
                                                ? Color(0xffeeeeee)
                                                : Color(0xFF212121),
                                              fontFamily: 'Roboto',
                                            )
                                          )
                                        ),
                                      )
                                    ),
                                  )
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}