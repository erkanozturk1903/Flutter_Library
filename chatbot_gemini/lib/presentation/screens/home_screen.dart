import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/welcome_section.dart';
import '../widgets/suggestions.dart';
import '../widgets/message_input.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/chat_message_list.dart';
import '../../data/services/gemini_service.dart';
import '../../data/models/message_model.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Message> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GeminiService _geminiService = GeminiService();
  bool _isTyping = false;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_messages.isEmpty) WelcomeSection(),
            if (_messages.isEmpty)
              Suggestions(onSuggestionTap: _handleSendMessage),
            Expanded(
              child: ChatMessageList(
                messages: _messages,
                scrollController: _scrollController,
                onSuggestionTap:
                    _handleSendMessage, // Tıklanan soruyu gönderme fonksiyonu
              ),
            ),
            if (_isTyping) TypingIndicator(),
            MessageInput(
              controller: _messageController,
              onSend: _handleSendMessage,
              onVoiceInput: _startVoiceInput,
              onImageUpload: _handleImageUpload,
            ),
          ],
        ),
      ),
    );
  }

  void _handleSendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      // Yeni mesajı listenin sonuna ekliyoruz
      _messages.add(Message(
        content: message,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });

    await _scrollToBottom();

    try {
      final response = await _geminiService.generateResponse(message);

      setState(() {
        // AI yanıtını da listenin sonuna ekliyoruz
        _messages.add(Message(
          content: response,
          isUser: false,
          timestamp: DateTime.now(),
        ));
        _isTyping = false;
      });

      await _scrollToBottom();
    } catch (e) {
      setState(() {
        _isTyping = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mesaj gönderilemedi: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Scroll metodunu da aşağıya kaydıracak şekilde güncelliyoruz
  Future<void> _scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _startVoiceInput() async {
    try {
      bool hasPermission = await _checkMicrophonePermission();
      if (!hasPermission) {
        _showPermissionDeniedDialog('mikrofon');
        return;
      }

      _showVoiceInputDialog();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ses kaydı başlatılamadı: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<bool> _checkMicrophonePermission() async {
    // Mikrofon izni kontrolü
    return true; // Implement permission check
  }

  void _showPermissionDeniedDialog(String permissionType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('İzin Gerekli'),
        content: Text('$permissionType için izin gerekiyor.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement settings navigation
            },
            child: const Text('Ayarlara Git'),
          ),
        ],
      ),
    );
  }

  void _showVoiceInputDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mic,
              size: 48,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            const Text('Konuşmak için basılı tutun'),
          ],
        ),
      ),
    );
  }

  void _handleImageUpload() async {
    try {
      bool hasPermission = await _checkGalleryPermission();
      if (!hasPermission) {
        _showPermissionDeniedDialog('galeri');
        return;
      }

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        String imageUrl = await _uploadImage(image);
        _handleSendMessage("![Resim]($imageUrl)");
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Resim yüklenemedi: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<bool> _checkGalleryPermission() async {
    // Galeri izni kontrolü
    return true; // Implement permission check
  }

  Future<String> _uploadImage(XFile image) async {
    // Resim yükleme işlemi
    return "image_url"; // Implement image upload
  }

  void _toggleTheme() async {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(
          isDarkMode: _isDarkMode,
          onThemeChanged: (isDark) {
            setState(() {
              _isDarkMode = isDark;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
