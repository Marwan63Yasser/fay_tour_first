import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RatingScreen extends StatefulWidget {
  String ro;
  int PlaceType; // 0--->area | 1--->hotel
  RatingScreen({Key? key, required this.ro,required this.PlaceType}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  
  int _rating = 0;
  final user = FirebaseAuth.instance.currentUser!;
  void _onRated(int rating) {
    setState(() {
      _rating = rating;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rating submitted'),
          content: Text('You rated this app $_rating stars.'),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                child: const Text('OK',),
                onPressed: () {
                        FirebaseFirestore.instance.collection("Ratings").add({
                    "Email": user.email,
                    "Fav": widget.ro,
                    "type": (widget.PlaceType == 0) ? "area" : "hotel",
                    "rate": _rating
                    });
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),)
              ),
            ),
          ],
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Ratings').where("Fav",isEqualTo: widget.ro).where("Email",isEqualTo: user.email).snapshots(),
      builder: (context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting) ?  Container()
        :  snapshot.data!.docs.isEmpty  
        ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: StarRating(
                rating: _rating,
                onRated: _onRated,
              ),
            )
        : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: StarRating(
                rating: snapshot.data?.docs[0]["rate"],
                onRated: _onRated,
              ),
            ); 

      }
    );
  }
}

class StarRating extends StatelessWidget {
  final int rating;
  final Function(int) onRated;

  const StarRating({Key? key, this.rating = 0, required this.onRated}) : super(key: key);

  Widget _buildStar(BuildContext context, int index) {
    IconData iconData = Icons.star_border;
    Color color = Colors.grey;

    if (index < rating) {
      iconData = Icons.star;
      color = Colors.amber;
    }

    return GestureDetector(
      onTap: () {
        onRated(index + 1);
      },
      child: Icon(
        iconData,
        color: color,
        size: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < 5; i++) _buildStar(context, i),
      ],
    );
  }
}
