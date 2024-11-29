
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Karanlık Tema'),
            value: isDarkMode,
            onChanged: onThemeChanged,
             ),
          ListTile(
            title: Text('Uygulama Hakkında'),
            leading: Icon(Icons.info),
            onTap: () => _showAboutDialog(context),
          ),
          ListTile(
            title: Text('Gizlilik Politikası'),
            leading: Icon(Icons.privacy_tip),
            onTap: () => _openPrivacyPolicy(context),
          ),
        ],
      ),
    );
  }
 void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AboutDialog(
        applicationName: 'AI Assistant',
        applicationVersion: '1.0.0',
        applicationIcon: Icon(Icons.assistant),
        children: [
          Text('Bu uygulama Gemini API kullanılarak geliştirilmiştir.'),
        ],
      ),
    );
  }

  void _openPrivacyPolicy(BuildContext context) {
    // Gizlilik politikası sayfasını aç
  }
}