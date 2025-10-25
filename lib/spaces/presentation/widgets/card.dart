import 'package:alquilafacil/profile/presentation/providers/profile_provider.dart';
import 'package:alquilafacil/reservation/presentation/screens/space_info.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../public/ui/providers/theme_provider.dart';
import '../../../public/ui/theme/main_theme.dart';

class SpaceCard extends StatefulWidget {
  final String address;
  final String price;
  final String imageUrl;
  final int id;
  final int userId;

  const SpaceCard({
    super.key,
    required this.address,
    required this.price,
    required this.imageUrl,
    required this.id,
    required this.userId,
  });

  @override
  _SpaceCardState createState() => _SpaceCardState();
}

class _SpaceCardState extends State<SpaceCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('favorite_${widget.id}') ?? false;
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
    });
    await prefs.setBool('favorite_${widget.id}', isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final spaceProvider = context.watch<SpaceProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    return GestureDetector(
      onTap: () async {
       try{
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SpaceInfo()));
       } finally{
         await spaceProvider.fetchSpaceById(widget.id);
         await profileProvider.fetchUsernameExpect(widget.userId);
       }
      },
      child: Card(
        color: themeProvider.isDarkTheme ? MainTheme.primary(context) : Colors.white,
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 180,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 240),
                        child: Text(
                          widget.address,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: MainTheme.contrast(context),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'S/. ${widget.price}',
                        style: TextStyle(
                          color: MainTheme.contrast(context),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                      IconButton(
                        onPressed: _toggleFavorite,
                        icon: Icon(
                          isFavorite ? Icons.star : Icons.star_border,
                          color: Colors.orange,
                          size: 30.0,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
