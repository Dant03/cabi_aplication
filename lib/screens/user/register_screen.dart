import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/models/user.dart';
import '/providers/user_provider.dart';
import '/routes/app_routes.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordSee = true;
  bool _isLoading = false;

  void _register() {
    setState(() {
      _isLoading = true;
    });

    final user = User(
      userId: 0, // El ID debe ser asignado por el backend
      name: _nameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      role: "user", // Ajusta esto según tu lógica de roles
      status: "active",
    );

    final userCreated = ref.read(registerProvider(user));
    // await ref.read(userProvider.notifier).register(user);
    // await ref.read(createUserProvider(user));

    setState(() {
      _isLoading = false;
    });
    if (userCreated.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed')),
      );
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration success')),
      );
      context.go(AppRoutes.tournamentUserScreen);// redireccion
      return;
    }

    // if (ref.read(userProvider) != null) {
    //   context.go(AppRoutes.home);
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Registration failed')),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: const Text('Registro'),
                  ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                context.push(AppRoutes.loginScreen);
              },
              child: const Text('Tienes una cuenta? Inicia Sesión aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
