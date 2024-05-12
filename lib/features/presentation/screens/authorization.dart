import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:SportSpirit/features/data/global_service.dart';
import 'package:SportSpirit/features/domain/api/cubit/administrator_cubit.dart';
import 'package:SportSpirit/features/presentation/screens/admin_panel.dart';

class Authorization extends StatefulWidget {
  const Authorization({super.key});
  @override
  State<Authorization> createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = service<AdministratorCubit>();
    return SafeArea(
      top: false,
      child: Scaffold(
        body: BlocConsumer<AdministratorCubit, AdministratorState>(
          bloc: cubit,
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_tutorial.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => context.pop(),
                            icon: const Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                      const Text(
                        'Добро пожаловать',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _loginController,
                        decoration: const InputDecoration(
                          labelText: 'Логин',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Пароль',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.loginAdministrators(
                                _loginController.text.trim(),
                                _passwordController.text.trim());
                          },
                          child: const Text('Вход'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (BuildContext context, AdministratorState state) {
            if (state is AuthorizationError) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Ошибка'),
                  content: const Text('Неверный логин или пароль'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ],
                ),
              );
            } else if (state is AuthorizationLoaded) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminPanel(
                    token: state.data.token,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
