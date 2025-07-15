import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class LearningHubPage extends StatefulWidget {
  const LearningHubPage({Key? key}) : super(key: key);

  @override
  State<LearningHubPage> createState() => _LearningHubPageState();
}

class _LearningHubPageState extends State<LearningHubPage> {
  final List<_Module> _modules = [
    _Module(
      name: 'Firebase',
      description: 'Realtime database, Authentication, Cloud Functions',
      imagePath: 'assets/images/firebase.png',
      url: 'https://firebase.google.com/docs',
      progressPercent: 0.7,
      xp: 350,
    ),
    _Module(
      name: 'Flutter',
      description: 'Build beautiful native apps for iOS and Android',
      imagePath: 'assets/images/flutter.png',
      url: 'https://flutter.dev/docs',
      progressPercent: 0.4,
      xp: 200,
    ),
    _Module(
      name: 'Google Cloud Platform',
      description: 'Cloud computing, storage, AI and more',
      imagePath: 'assets/images/gcp.png',
      url: 'https://cloud.google.com/training',
      progressPercent: 0.3,
      xp: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress Tracking',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ..._modules.map(
            (m) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${m.name} - ${(m.progressPercent * 100).toStringAsFixed(0)}% complete, XP: ${m.xp}'),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: m.progressPercent,
                      color: Color(0xFF001A66),
                      backgroundColor:
                          isLight ? Color(0xffccd9ff) : Color(0xFF001A66),
                      minHeight: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ..._modules.map(
            (module) => Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    module.imagePath,
                    width: 60, // Updated size for bigger image
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  module.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(module.description),
                trailing: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/open-arrow.svg', // Path to your open-arrow.svg
                    width: 24,
                    height: 24,
                    color: Color(0xFF001A66), // Color can be adjusted as needed
                  ),
                  onPressed: () => _openUrl(module.url),
                ),
                onTap: () => _openUrl(module.url),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open $url')),
      );
    }
  }
}

class _Module {
  final String name;
  final String description;
  final String imagePath;
  final String url;
  final double progressPercent;
  final int xp;

  _Module({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.url,
    required this.progressPercent,
    required this.xp,
  });
}
