import 'package:flutter/material.dart';
import 'package:incident_tracker/widgets/setting_tile.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PackageInfo? _packageInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _packageInfo = packageInfo;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Information Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // App Icon
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade600,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.security,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // App Name
                        Text(
                          _packageInfo?.appName ?? 'Incident Tracker',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // App Description
                        Text(
                          'Track and manage incidents efficiently',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Settings Section Header
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 12),
                    child: Text(
                      'App Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  
                  // App Name Setting
                  SettingsTile(
                    title: 'App Name',
                    subtitle: _packageInfo?.appName ?? 'Incident Tracker',
                    icon: Icons.apps,
                  ),
                  
                  // App Version Setting
                  SettingsTile(
                    title: 'App Version',
                    subtitle: _packageInfo?.version ?? '1.0.0',
                    icon: Icons.info_outline,
                  ),
                  
                  // Package Name Setting
                  if (_packageInfo?.packageName != null)
                    SettingsTile(
                      title: 'Package Name',
                      subtitle: _packageInfo!.packageName,
                      icon: Icons.inventory,
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // Additional Features Section
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 12),
                    child: Text(
                      'Features',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),

                  SettingsTile(
                    title: 'Offline Storage',
                    subtitle: 'SQLite database for local data storage',
                    icon: Icons.storage,
                    iconColor: Colors.green.shade600,
                  ),

                  SettingsTile(
                    title: 'User Authentication',
                    subtitle: 'Secure login with API integration',
                    icon: Icons.security,
                    iconColor: Colors.orange.shade600,
                  ),

                  SettingsTile(
                    title: 'Image Support',
                    subtitle: 'Camera and gallery photo support',
                    icon: Icons.camera_alt,
                    iconColor: Colors.purple.shade600,
                  ),
                ],
              ),
            ),
    );
  }
} 