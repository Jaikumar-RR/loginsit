import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<SettingItem> settingsOptions = [
    SettingItem(
      title: 'Account',
      icon: Icons.account_circle,
      content: [
        SettingContent(title: 'Account Details', icon: Icons.person),
        SettingContent(title: 'Language', icon: Icons.language),
        SettingContent(title: 'Set Status', icon: Icons.info),
        // Add more account-related content here
      ],
    ),
    SettingItem(
      title: 'Notifications',
      icon: Icons.notifications,
      content: [
        SettingContent(title: 'Notification Settings', icon: Icons.settings),
        // Add notification-related content here
      ],
    ),
    SettingItem(
      title: 'Appearance',
      icon: Icons.color_lens,
      content: [
        SettingContent(title: 'Dark Mode', icon: Icons.dark_mode),
        SettingContent(title: 'Light Mode', icon: Icons.light_mode),
        // Add more appearance-related content here
      ],
    ),
    SettingItem(
      title: 'Privacy and Security',
      icon: Icons.lock,
      content: [
        SettingContent(title: 'Privacy Settings', icon: Icons.privacy_tip),
        // Add privacy and security-related content here
      ],
    ),
    SettingItem(
      title: 'Help and Support',
      icon: Icons.help,
      content: [
        SettingContent(title: 'Help Center', icon: Icons.help_outline),
        // Add help and support-related content here
      ],
    ),
    SettingItem(
      title: 'Developers',
      icon: Icons.developer_mode,
      content: [
        SettingContent(title: 'Developer Tools', icon: Icons.build),
        // Add developer-related content here
      ],
    ),
    SettingItem(
      title: 'About',
      icon: Icons.info,
      content: [
        SettingContent(title: 'About Us', icon: Icons.info_outline),
        // Add about-related content here
      ],
    ),
  ];
  bool _hovering = false;

  TextEditingController searchController = TextEditingController();

  List<SettingItem> filteredSettings = [];

  @override
  void initState() {
    super.initState();
    filteredSettings.addAll(settingsOptions);
  }

  void filterSettings(String query) {
    setState(() {
      filteredSettings = settingsOptions
          .where((item) =>
              item.title.toLowerCase().contains(query.toLowerCase()) ||
              (item.content != null &&
                  item.content!.any((contentItem) => contentItem.title
                      .toLowerCase()
                      .contains(query.toLowerCase()))))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: CustomPaint(
          painter: CurvedAppBar(),
          child: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: filterSettings,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: 'Search settings...',
                ),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSettings.length,
                itemBuilder: (context, index) {
                  return AnimatedSettingTile(
                    title: filteredSettings[index].title,
                    icon: filteredSettings[index].icon,
                    content: filteredSettings[index].content,
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                // Implement logout functionality here
                print('Logout pressed');
              },
              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _hovering = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _hovering = false;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: _hovering
                        ? LinearGradient(
                            colors: [Colors.blueGrey, Colors.blue.shade700],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                        : LinearGradient(
                            colors: [Colors.blue.shade600, Colors.blueGrey],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 140, vertical: 9),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvedAppBar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color(0xFF607D8B),
          Color(0xFF00B4DB),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
          size.width / 2, size.height - 50, size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SettingItem {
  final String title;
  final IconData icon;
  final List<SettingContent>? content; // Use nullable List<SettingContent>

  SettingItem({
    required this.title,
    required this.icon,
    this.content, // Make content nullable
  });
}

class SettingContent {
  final String title;
  final IconData icon;

  SettingContent({required this.title, required this.icon});
}

class AnimatedSettingTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<SettingContent>? content;

  AnimatedSettingTile({
    required this.title,
    required this.icon,
    this.content,
  });

  @override
  _AnimatedSettingTileState createState() => _AnimatedSettingTileState();
}

class _AnimatedSettingTileState extends State<AnimatedSettingTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(widget.icon, color: Colors.blue),
      title: Row(
        children: [
          Text(
            ' ${widget.title}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      children: (widget.content ?? []).map((item) {
        return Padding(
          padding: const EdgeInsets.only(left: 48.0),
          child: ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: () {
              // Handle the content item's action here
              print('$item.title tapped');
            },
          ),
        );
      }).toList(),
    );
  }
}

class AnimatedSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  AnimatedSearchBar({
    required this.controller,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
