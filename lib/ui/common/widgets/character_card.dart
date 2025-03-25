import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rick_morty_effective/core/model/character.dart';

class CharacterCard extends StatefulWidget {
  const CharacterCard({super.key, this.onPressed, required this.isFavorite, required this.item});

  final VoidCallback? onPressed;
  final bool isFavorite;
  final Results item;

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          children: [
            Container(color: Theme.of(context).colorScheme.primaryContainer),
            Row(
              children: [
                SizedBox(
                  height: 128,
                  width: 128,
                  child: CachedNetworkImage(
                    imageUrl: widget.item.image ?? '',
                    fit: BoxFit.contain,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    cacheManager: CacheManager(Config(
                      'CACHED_NETWORK_IMAGE',
                      stalePeriod: Duration(days: 30),
                    )),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('${widget.item.name}', textAlign: TextAlign.center),
                      Text('gender: ${widget.item.gender}', textAlign: TextAlign.start),
                      Text(
                          'type: ${widget.item.type == '' || widget.item.type == null ? 'unknown' : widget.item.type}',
                          textAlign: TextAlign.start),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              right: -8,
              bottom: -8,
              child: IconButton(
                onPressed: widget.onPressed,
                icon: Icon(
                  widget.isFavorite ? Icons.star : Icons.star_outline,
                  color:
                      widget.isFavorite ? Colors.amber : Theme.of(context).primaryIconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
