import 'package:absensi_app/core/components/components.dart';
import 'package:absensi_app/core/core.dart';
import 'package:absensi_app/features/pages/home/main_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    usernameController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                width: 150,
                height: 150,
                'assets/images/idbc_logo.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: usernameController,
                label: 'Email of Username',
                hintText: 'Masukkan email atau username',
                onChanged: (value) {},
                prefixIcon: Icon(Icons.email),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                hintText: 'Masukkan password',
                obscureText: true,
                onChanged: (value) {},
                prefixIcon: Icon(Icons.password),
              ),
              const SizedBox(height: 20),
              Button(
                disable: !(isValid),
                onPressed: () async {
                  final response = await http.post(
                    Uri.parse('http://127.0.0.1:8000/api/login'), // Ganti dengan IP backend Laravel kamu
                    headers: {
                      'Content-Type': 'application/json',
                      'Accept': 'application/json',
                    },
                    body: jsonEncode({
                      'email': usernameController.text,
                      'password': passwordController.text,
                    }),
                  );

                  if (response.statusCode == 200) {
                    final data = jsonDecode(response.body);
                    final token = data['token'];
                    // Simpan token ke local storage kalau perlu

                    context.pushReplacement(const MainPage());
                  } else {
                    final data = jsonDecode(response.body);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(data['message'] ?? 'Login gagal')),
                    );
                  }
                },

                label: 'Masuk',
              ),
            ],
          ),
        ),
      ),
    );
  }
  bool get isValid {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}
