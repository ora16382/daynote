import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../../oss_licenses.dart';

class OssLicensesView extends StatefulWidget {
  const OssLicensesView({super.key});

  @override
  State<OssLicensesView> createState() => _OssLicensesViewState();
}

class _OssLicensesViewState extends State<OssLicensesView> {
  static Future<List<Package>> loadLicenses() async {
    // merging non-dart dependency list using LicenseRegistry.
    final lm = <String, List<String>>{};
    await for (var l in LicenseRegistry.licenses) {
      for (var p in l.packages) {
        final lp = lm.putIfAbsent(p, () => []);
        lp.addAll(l.paragraphs.map((p) => p.text));
      }
    }
    final licenses = allDependencies.toList();
    for (var key in lm.keys) {
      licenses.add(
        Package(
          name: key,
          description: '',
          authors: [],
          version: '',
          license: lm[key]!.join('\n\n'),
          isMarkdown: false,
          isSdk: false,
          dependencies: [],
        ),
      );
    }
    return licenses..sort((a, b) => a.name.compareTo(b.name));
  }

  static final _licenses = loadLicenses();

  @override
  Widget build(BuildContext context) {
    logger.i('qwer');
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Package>>(
        future: _licenses,
        initialData: const [],
        builder: (context, snapshot) {
          return ListView.separated(
            padding: const EdgeInsets.all(0),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final package = snapshot.data![index];
              return ListTile(
                title: Text('${package.name} ${package.version}'),
                subtitle:
                    package.description.isNotEmpty
                        ? Text(package.description)
                        : null,
                trailing: const Icon(Icons.chevron_right),
                onTap:
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => MiscOssLicenseSingle(package: package),
                      ),
                    ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        },
      ),
    );
  }
}

class MiscOssLicenseSingle extends StatelessWidget {
  final Package package;

  const MiscOssLicenseSingle({super.key, required this.package});

  String _bodyText() {
    return package.license!
        .split('\n')
        .map((line) {
          if (line.startsWith('//')) line = line.substring(2);
          line = line.trim();
          return line;
        })
        .join('\n');
  }

  @override
  Widget build(BuildContext context) {
    logger.e('asdf');
    return Scaffold(
      appBar: AppBar(
        title: Text('${package.name} ${package.version}'),
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
        elevation: 0.0,
        bottomOpacity: 0.0,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            if (package.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  left: 12.0,
                  right: 12.0,
                ),
                child: Text(
                  package.description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            if (package.homepage != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  left: 12.0,
                  right: 12.0,
                ),
                child: InkWell(
                  child: Text(
                    package.homepage!,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () => launchUrl(Uri.parse(package.homepage!)),
                ),
              ),
            if (package.description.isNotEmpty || package.homepage != null)
              const Divider(),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 12.0,
                right: 12.0,
              ),
              child: Text(
                _bodyText(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
