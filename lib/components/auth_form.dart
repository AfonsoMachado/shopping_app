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
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.signin;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isSignin() => _authMode == AuthMode.signin;

  bool _isSignup() => _authMode == AuthMode.signup;

  void _switchAuthMode() {
    setState(() {
      _authMode = _isSignin() ? AuthMode.signup : AuthMode.signin;
    });
  }

  _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isLoading = true);
    _formKey.currentState?.save();
    if (_isSignin()) {
      //   Logar
    } else {
      //   registrar
    }
    setState(() => _isLoading = false);
  }

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
        height: _isSignin() ? 310 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
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
              if (_isSignup())
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Senha'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  validator: _isSignin()
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
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 8),
                      ),
                      child: Text(_authMode == AuthMode.signin
                          ? 'ENTRAR'
                          : 'REGISTRAR'),
                    ),
              const Spacer(),
              TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(_isSignin()
                      ? 'DESEJA REGISTRAR-SE?'
                      : 'JÁ POSSUI CONTA?'))
            ],
          ),
        ),
      ),
    );
  }
}