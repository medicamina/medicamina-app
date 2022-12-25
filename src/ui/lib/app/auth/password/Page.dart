import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:medicamina/app/State.dart';
import 'package:medicamina/app/auth/AppBar.dart';
import 'package:medicamina/app/auth/States.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedicaminaAuthPasswordResetPage extends StatefulWidget {
  const MedicaminaAuthPasswordResetPage({Key? key}) : super(key: key);

  @override
  State<MedicaminaAuthPasswordResetPage> createState() => _MedicaminaAuthPasswordResetPage();
}

class _MedicaminaAuthPasswordResetPage extends State<MedicaminaAuthPasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width > 800 ? MediaQuery.of(context).size.width * 0.2 : MediaQuery.of(context).size.width * 0.1, top: 24),
                        child: Text(
                          "Reset password",
                          style: Modular.get<MedicaminaThemeState>().getDarkMode()
                              ? Theme.of(context).textTheme.displayMedium?.merge(const TextStyle(color: Colors.white))
                              : Theme.of(context).textTheme.displayMedium?.merge(
                                    const TextStyle(color: Colors.black87),
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width > 800 ? MediaQuery.of(context).size.width * 0.205 : MediaQuery.of(context).size.width * 0.115),
                        child: Text("Enter your e-mail address to get your account back", style: Theme.of(context).textTheme.displaySmall?.merge(const TextStyle(fontSize: 20))),
                      ),
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
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        AutofillGroup(
                          child: Padding(
                            padding: MediaQuery.of(context).size.width > 800 ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.20, right: MediaQuery.of(context).size.width * 0.2) : const EdgeInsets.only(left: 24, right: 24),
                            child: TextFormField(
                              autocorrect: false,
                              enableSuggestions: false,
                              autofillHints: const [AutofillHints.email],
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'E-mail address',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              onChanged: (text) {
                                setState(() {
                                  _email = text;
                                });
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
                                        await _supabaseClient.auth.resetPasswordForEmail(_email);
                                      } on AuthException catch (err, _) {
                                        // widget.snackBarError(err);
                                      }
                                      Modular.get<MedicaminaAuthLoadingState>().setLoading(false);
                                    }
                                  },
                            child: const Text(
                              'SEND LINK',
                              style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.75),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
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