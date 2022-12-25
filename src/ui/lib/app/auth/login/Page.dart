import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:medicamina/app/State.dart';
import 'package:medicamina/app/auth/AppBar.dart';
import 'package:medicamina/app/auth/States.dart';
import 'package:medicamina/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedicaminaAuthLoginPage extends StatefulWidget {
  const MedicaminaAuthLoginPage({Key? key}) : super(key: key);

  @override
  State<MedicaminaAuthLoginPage> createState() => _MedicaminaAuthLoginPage();
}

class _MedicaminaAuthLoginPage extends State<MedicaminaAuthLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final SupabaseClient _supabaseClient = Modular.get<SupabaseClient>();
  late bool _loading;
  late StreamSubscription _loadingStream;

  @override
  void initState() {
    super.initState();
    _loading = Modular.get<MedicaminaAuthLoadingState>().getLoading();
    _loadingStream = Modular.get<MedicaminaAuthLoadingState>().getStream().listen((value) {
      setState(() {
        _loading = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _loadingStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Modular.get<MedicaminaAuthAppBarWidget>(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width > 800 ? MediaQuery.of(context).size.width * 0.2 : MediaQuery.of(context).size.width * 0.1, top: 24),
                      child: Text(
                        'Welcome',
                        style: Modular.get<MedicaminaThemeState>().getDarkMode()
                            ? Theme.of(context).textTheme.displayMedium?.merge(const TextStyle(color: Colors.white))
                            : Theme.of(context).textTheme.displayMedium?.merge(
                                  const TextStyle(color: Colors.black87),
                                ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width > 800 ? MediaQuery.of(context).size.width * 0.205 : MediaQuery.of(context).size.width * 0.115),
                      child: Text('Sign in to continue', style: Theme.of(context).textTheme.displaySmall?.merge(const TextStyle(fontSize: 20))),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: AutofillGroup(
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          Padding(
                            padding: MediaQuery.of(context).size.width > 800 ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.20, right: MediaQuery.of(context).size.width * 0.2) : const EdgeInsets.only(left: 24, right: 24),
                            child: TextFormField(
                              autofillHints: const [AutofillHints.email],
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'E-mail address',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              onChanged: (text) {
                                _email = text;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Empty email';
                                }
                                bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                                if (!emailValid) {
                                  return 'Invalid email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: MediaQuery.of(context).size.width > 800 ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.20, right: MediaQuery.of(context).size.width * 0.2) : const EdgeInsets.only(left: 24, right: 24),
                            child: TextFormField(
                              autofillHints: const [AutofillHints.password],
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock_outline),
                              ),
                              onChanged: (text) {
                                _password = text;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Empty password';
                                }
                                if (_password.length < 6) {
                                  return 'Invalid password';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 18),
                          Padding(
                            padding: MediaQuery.of(context).size.width > 800 ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.20, right: MediaQuery.of(context).size.width * 0.2) : const EdgeInsets.only(left: 24, right: 24),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(minimumSize: Size(const Size.fromHeight(40).width, 42)),
                              onPressed: _loading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        Modular.get<MedicaminaAuthLoadingState>().setLoading(true);
                                        try {
                                          await _supabaseClient.auth.signInWithPassword(email: _email, password: _password);
                                        } on AuthException catch (err, _) {
                                          // widget.snackBarError(err);
                                          return;
                                        }
                                        Modular.get<MedicaminaAuthLoadingState>().setLoading(false);
                                        Modular.to.navigate('/dash/home');
                                      }
                                    },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.75),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(left: 22, right: 22, top: 15, bottom: 15),
                                ),
                                onPressed: () {
                                  Modular.to.pushNamedOrPopUntil('/password');
                                },
                                child: const Text(
                                  'Reset password',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}