import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  // กำหนดขนาดการ์ดให้เป็นค่าคงที่เพื่อให้ใช้งานง่ายและปรับแต่งได้จากที่เดียว
  final double _cardSize = 168;
  final double _artistCardSize = 158;
  final List<String> _listArtist = const [
    'https://i.scdn.co/image/ab6761610000e5eb89ffabe57a25cedeca3309e7',
    'https://i.scdn.co/image/4e3e13c8b993bde9898e49509fb9ae121636e05f',
    'https://i.scdn.co/image/ab6761610000f178ae07171f989fb39736674113',
    'https://i.scdn.co/image/a318c54208af38364d131a54ced2416423696018',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(title: 'Popular radio'),
              SizedBox(
                height: _cardSize,
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Color randomColor = randomBgColor();
                    return Container(
                      width: _cardSize,
                      height: _cardSize,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        // ใช้ randomBgColor() เพื่อสุ่มสีพื้นหลังให้แต่ละการ์ดมีสีแตกต่างกัน
                        color: randomColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.play_circle),
                                Text(
                                  'Radio'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //img artis
                          Expanded(
                            child: _artistImage(
                              cardSize: _cardSize,
                              randomColor: randomColor,
                            ),
                          ),
                          //artis
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  'Artist Name'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12),
              TitleWidget(title: 'Popular artist'),
              SizedBox(
                height: _artistCardSize * 1.25,
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _artistItem(
                      imageUrl:
                          _listArtist[Random().nextInt(_listArtist.length)],
                      title: 'Artist Name',
                    );
                  },
                ),
              ),
              TitleWidget(title: 'Popular Albums and singles'),
              SizedBox(
                height: _cardSize,
                child: ListView.separated(
                  padding: EdgeInsets.all(0),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    Color randomColor = randomBgColor();
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: _cardSize,
                        height: _cardSize,
                        decoration: BoxDecoration(
                          // ใช้ randomBgColor() เพื่อสุ่มสีพื้นหลังให้แต่ละการ์ดมีสีแตกต่างกัน
                          color: randomColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Image.network(
                              _listArtist[Random().nextInt(_listArtist.length)],
                              height: _cardSize,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12),
              TitleWidget(title: 'เพล์ลิสแนะนำสำหรับคุณ'),
              SizedBox(
                height: _cardSize * 1.35,
                child: ListView.separated(
                  padding: EdgeInsets.all(0),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: _cardSize,
                        height: _cardSize,
                        child: Column(
                          children: [
                            Image.network(
                              _listArtist[Random().nextInt(_listArtist.length)],
                              height: _cardSize,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has',
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12),
              TitleWidget(title: 'Charts'),
              SizedBox(
                height: _cardSize,
                child: ListView.separated(
                  padding: EdgeInsets.all(0),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    Color randomColor = randomBgColor();
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: _cardSize,
                        height: _cardSize,
                        decoration: BoxDecoration(
                          // ใช้ randomBgColor() เพื่อสุ่มสีพื้นหลังให้แต่ละการ์ดมีสีแตกต่างกัน
                          color: randomColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Image.network(
                              _listArtist[Random().nextInt(_listArtist.length)],
                              height: _cardSize,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  // สุ่มสีพื้นหลังแบบสุ่ม RGB เพื่อให้แต่ละการ์ดมีสีพื้นหลังที่ไม่เหมือนกัน
  Color randomBgColor() {
    return Color.fromARGB(
      255,
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
    );
  }

  // สร้าง avatar circles ที่ทับซ้อนกัน มี 3 วง: 2 วงอยู่ด้านข้าง (ซ้าย-ขวา) และ 1 วงอยู่ตรงกลาง
  Widget _artistImage({required double cardSize, required Color randomColor}) {
    double sizeCenter = 90;
    double sizeLeft = 60;
    double sizeRight = 60;
    return Row(
      children: [
        ClipRRect(
          child: SizedBox(
            // ใช้ width: double.infinity เพื่อให้ Stack กว้างเต็มพื้นที่ที่มีให้
            width: cardSize,
            height: sizeCenter,
            child: Stack(
              // clipBehavior: Clip.none เพื่อให้วงต่างๆ สามารถทับซ้อนกันได้โดยไม่ถูกตัดออก
              clipBehavior: Clip.none,
              children: [
                // วงซ้าย: วางตำแหน่งที่ left: 0
                Positioned(
                  left: -5,
                  top: (sizeCenter - sizeLeft) / 2,
                  bottom: (sizeCenter - sizeLeft) / 2,
                  child: Container(
                    width: sizeLeft,
                    height: sizeLeft,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      // borderRadius: 50 เพื่อทำให้เป็นวงกลม (ขนาด 70/2 = 35 แต่ใช้ 50 ก็ได้เพราะจะกลมหมด)
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://i.scdn.co/image/ab6761610000e5ebae07171f989fb39736674113',
                      ),
                    ),
                  ),
                ),
                // วงขวา: วางตำแหน่งที่ right: 0
                Positioned(
                  right: -5,
                  top: (sizeCenter - sizeRight) / 2,
                  bottom: (sizeCenter - sizeRight) / 2,
                  child: Container(
                    width: sizeRight,
                    height: sizeRight,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://i.scdn.co/image/2f0c6c465a83cd196e651e3d4e7625ba799a6f60',
                      ),
                    ),
                  ),
                ),
                // วงกลาง: วางตำแหน่งที่ left: 35 (ครึ่งหนึ่งของ width: 70) เพื่อให้อยู่ตรงกลางระหว่างสองวงข้าง
                // วงนี้จะทับซ้อนกับวงซ้ายและวงขวา
                Positioned(
                  right: (cardSize / 2) - (sizeCenter / 2),
                  top: 0,
                  child: Container(
                    width: sizeCenter,
                    height: sizeCenter,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: randomColor, width: 3),
                    ),
                    // เพิ่ม Icon เพื่อแสดงว่าเป็น avatar ของคน
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://i.scdn.co/image/ab6761610000e5eb89ffabe57a25cedeca3309e7',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _artistItem({required String imageUrl, String? title}) {
    return Column(
      children: [
        Container(
          width: _artistCardSize,
          height: _artistCardSize,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: randomBgColor(),
            borderRadius: BorderRadius.circular(99),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),

            child: Image.network(
              imageUrl,
              height: _artistCardSize,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title ?? 'Artist Name',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
