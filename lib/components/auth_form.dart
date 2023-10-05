import 'package:flutter/material.dart';

enum AuthMode {
  signup,
  signin,
}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.signin;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  _submit() {}

  @override
  Widget build(BuildContext context) {
    // tamanho do dispositivo
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 320,
        width: deviceSize.width * 0.75,
        child: Column(
          children: [
            TextFormField(
              onSaved: (email) => _authData['email'] = email ?? '',
              decoration: const InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              validator: (_email) {
                final email = _email ?? '';

                if (email.trim().isEmpty || !email.contains('@')) {
                  return 'Informe um e-mail válido';
                }

                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              onSaved: (password) => _authData['password'] = password ?? '',
              decoration: const InputDecoration(labelText: 'Senha'),
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              validator: (_password) {
                final password = _password ?? '';

                if (password.isEmpty || password.length < 5) {
                  return 'Informe uma senha válida';
                }

                return null;
              },
            ),
            if (_authMode == AuthMode.signup)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                validator: _authMode == AuthMode.signin
                    ? null
                    : (_password) {
                        final password = _password ?? '';
                        if (password != _passwordController.text) {
                          return 'Senhas informadas não conferem.';
                        }
                        return null;
                      },
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              ),
              child:
                  Text(_authMode == AuthMode.signin ? 'ENTRAR' : 'REGISTRAR'),
            )
          ],
        ),
      ),
    );
  }
}
