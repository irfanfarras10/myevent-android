import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myevent_android/colors/myevent_color.dart';

class EventDetailScreen extends StatelessWidget {
  final int? id;
  const EventDetailScreen({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Event',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyEventColor.secondaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
            tooltip: 'Ubah Data Event',
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
            tooltip: 'Hapus Event',
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15.0),
              color: Colors.grey.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'STATUS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: MyEventColor.secondaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Belum Di Publish',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: MyEventColor.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: CachedNetworkImage(
                imageUrl: '',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.black38,
                  child: Center(
                    child: Icon(
                      Icons.image,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Event',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: MyEventColor.secondaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Webinar Data Analytics',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: MyEventColor.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: MyEventColor.primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        child: Text(
                          'Webinar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyEventColor.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deskripsi Event',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyEventColor.secondaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ex ipsum, ultrices in egestas blandit, gravida eget odio. Integer vestibulum neque ut mi maximus, cursus tempus lorem commodo. In egestas tortor nec elementum efficitur. Curabitur ac ultrices felis. Donec faucibus, neque nec cursus tincidunt, arcu ipsum rhoncus est, vitae sagittis neque libero eget ligula. Praesent mattis leo eget dolor porta, finibus interdum nisl mollis. Sed fringilla est ut congue volutpat. Donec ligula velit, bibendum et metus in, ullamcorper mollis justo. Pellentesque malesuada metus id gravida elementum. Aliquam bibendum at ante eget lacinia. Sed semper lacus orci. Donec tincidunt mi arcu, maximus auctor odio tincidunt ac. Nullam a lorem sagittis neque vestibulum eleifend. ',
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanggal dan Waktu Event',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyEventColor.secondaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 16.5,
                            color: Colors.black38,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '18 Juni 2022 - 19 Juni 2022',
                            style: TextStyle(
                              color: MyEventColor.secondaryColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
