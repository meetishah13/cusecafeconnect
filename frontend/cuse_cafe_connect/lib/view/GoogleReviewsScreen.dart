import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoogleReviewsScreen extends StatefulWidget {
  final String cafeName;
  final double cafeLat;
  final double cafeLong;

  GoogleReviewsScreen({
    required this.cafeName,
    required this.cafeLat,
    required this.cafeLong,
  });

  @override
  _GoogleReviewsScreenState createState() => _GoogleReviewsScreenState();
}

class _GoogleReviewsScreenState extends State<GoogleReviewsScreen> {
  final String apiKey = 'AIzaSyDwRuXh7RhFAtuW2SKDYDRCVS15KQlfW0U';
  late String placeName ;
  final String locationBias = '43.039754,-76.1350572'; // Coordinates of Bird Library

  String placeId = '';
  List<Map<String, dynamic>> reviews = [];
  double overallRating = 0.0;

  @override
  void initState() {
    super.initState();
    placeName= widget.cafeName;
    // locationBias = (widget.cafeLat+','+widget.cafeLong).toString();
    fetchPlaceId();
  }

  Future<void> fetchPlaceId() async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$placeName&inputtype=textquery&locationbias=circle:500@${widget.cafeLat},${widget.cafeLong}&key=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['candidates'] != null && data['candidates'].isNotEmpty) {
        setState(() {
          placeId = data['candidates'][0]['place_id'];
          fetchReviews();
        });
      }
    } else {
      throw Exception('Failed to fetch place details');
    }
  }

  Future<void> fetchReviews() async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=reviews,rating&key=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['result'] != null) {
        setState(() {
          if (data['result']['reviews'] != null) {
            reviews = List<Map<String, dynamic>>.from(data['result']['reviews']);
          }
          overallRating = data['result']['rating'] != null ? data['result']['rating'].toDouble() : 0.0;
        });
      }
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cafeName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Overall Rating: ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: List.generate(
                    overallRating.round(),
                        (index) => Icon(Icons.star, color: Colors.amber),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reviews[index]['author_name'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFF76900), // Changed to black for better visibility
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          reviews[index]['text'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF040261), // Review text color
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Rating: ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: List.generate(
                                reviews[index]['rating'],
                                    (index) => Icon(Icons.star, color: Colors.amber),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
