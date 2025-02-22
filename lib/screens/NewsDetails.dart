import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String url;
  final String source;


  NewsDetailsScreen({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.url,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("News Details",style: Theme.of(context).textTheme.titleLarge,)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 310,
              child: CachedNetworkImage(
        
                imageUrl: imageUrl.isNotEmpty
                    ? imageUrl
                    : 'https://media.istockphoto.com/id/1339466666/vector/breaking-news.jpg?s=612x612&w=0&k=20&c=miuVhN91dJNC5xonwQrSndDTlFGdGrYz866M422cmBQ=',
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 21)),
            ),
            Row(
              spacing: 5,
              children: [
                Container(
                  height: 39,
                  width: 39,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Image.network(
                    'https://media.istockphoto.com/id/1339466666/vector/breaking-news.jpg?s=612x612&w=0&k=20&c=miuVhN91dJNC5xonwQrSndDTlFGdGrYz866M422cmBQ=' ??
                        '${imageUrl}',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    source,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                    maxLines: 2, // يسمح بسطرين
                    overflow: TextOverflow.ellipsis, // يحط "..." لو النص طويل
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(description, style:Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16,color: Colors.grey.shade700)),
            ),
        
            InkWell(
              onTap: ()async {
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Cannot open link")),
                  );
                }
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("view All", style:Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16,color: Colors.cyan.shade700)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text("Dev By Eng : M7md Yasser Algndy", style:Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 8,color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
