import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  bool _isLoading = false;
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> _authenticate() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // For demo purposes, skip Firebase auth
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', emailController.text.trim());
      await prefs.setString('userName', nameController.text.trim().isNotEmpty
          ? nameController.text.trim()
          : 'Demo User');

      // Mock sync with backend
      try {
        await http.post(
          Uri.parse('http://10.0.2.2:3000/api/auth/sync'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'uid': 'demo_user',
            'email': emailController.text.trim(),
            'displayName': nameController.text.trim().isNotEmpty
                ? nameController.text.trim()
                : 'Demo User',
          }),
        );
      } catch (e) {
        debugPrint('Backend sync failed, proceeding anyway for demo: $e');
      }

      // Always proceed for demo
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/main');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Authentication failed. Please try again.';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 48,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 64),
                  Text(
                    _isLogin ? 'Sign In' : 'Create Account',
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.2,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isLogin
                        ? 'Access your music and mixes'
                        : 'Start your music journey',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 64),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 17, color: Colors.white),
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF1C1C1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      errorStyle: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(fontSize: 17, color: Colors.white),
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF1C1C1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      errorStyle: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  if (!_isLogin)
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: nameController,
                          style: const TextStyle(fontSize: 17, color: Colors.white),
                          validator: (value) {
                            if (!_isLogin && (value == null || value.isEmpty)) {
                              return 'Please enter your display name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Display Name',
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            filled: true,
                            fillColor: const Color(0xFF1C1C1E),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            errorStyle: const TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _authenticate,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF1826F8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              _isLogin ? 'Sign In' : 'Sign Up',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                          _errorMessage = null;
                        });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        _isLogin
                            ? 'Create an account'
                            : 'Already have an account? Sign In',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1826F8),
                        ),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            _isLogin ? 'Sign In' : 'Sign Up',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pushReplacementNamed('/main'),
                      child: const Text(
                        'Demo Mode (Skip Auth)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
