import 'package:cif/module/auth/login_notifier.dart';
import 'package:cif/utils/button_custom.dart';
import 'package:cif/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginNotifier(context: context),
      child: Consumer<LoginNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: colorPrimary,
                ),
              )),
              Container(
                width: 800,
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: FocusTraversalGroup(
                  child: Form(
                    key: value.keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 64,
                        ),
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Sign In for access to application",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "USer ID",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: value.username,
                          maxLines: 1,
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Wajib diisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "User ID",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          controller: value.password,
                          maxLines: 1,
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Wajib diisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ButtonPrimary(
                          onTap: () {
                            value.cek();
                          },
                          name: "Sign In",
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
