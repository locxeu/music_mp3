import 'package:flutter/material.dart';

class FavouriteArtist extends StatefulWidget {
  const FavouriteArtist({Key? key}) : super(key: key);

  @override
  State<FavouriteArtist> createState() => _FavouriteArtistState();
}

class _FavouriteArtistState extends State<FavouriteArtist> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: const [
                CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/favorite_artist/taylor.jpg'),
                  radius: 80,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Taylor Swift',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: const [
                CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/favorite_artist/chillies.jpg'),
                  radius: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Chillies',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: const [
                CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/favorite_artist/coldplay.jpg'),
                  radius: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Cold Play',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: const [
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/favorite_artist/quaivattihon.png'),
                  radius: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Quái vật tí hon',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: const [
                CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/favorite_artist/buctuong.jpg'),
                  radius: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Bức Tường',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ),
    );
  }
}
