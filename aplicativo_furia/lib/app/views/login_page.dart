import 'package:aplicativo_furia/app/controllers/login_page_controller.dart';
import 'package:aplicativo_furia/shared/themes/colors.dart';
import 'package:aplicativo_furia/shared/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginPageController(),
      child: Builder(builder: (context) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _loginProvider = Provider.of<LoginPageController>(context);
        return Scaffold(
          backgroundColor: primaryColor,
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/furia_logo.png'),
                        fit: BoxFit.contain,
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'WELCOME BACK!',
                    textAlign: TextAlign.center,
                    style: RAJDHANI(
                      fontSize: 40,
                      color: textoBranco,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            onChanged: _loginProvider.setEmail,
                            controller: _loginProvider.controllerEmail,
                            style: const TextStyle(
                              color: textoBranco,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.email,
                                color: textoCinzaClaro,
                              ),
                              filled: true,
                              fillColor: fundoSecundario,
                              hintText: 'Email',
                              hintStyle: RAJDHANI(
                                fontSize: 20,
                                color: textoCinzaClaro,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  !value.contains('@') ||
                                  !value.contains('.com')) {
                                return 'Email inválido';
                              } else if (value.length < 6) {
                                return 'Email muito curto';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                              onChanged: _loginProvider.setPassword,
                              controller: _loginProvider.controllerPassword,
                              obscureText: true,
                              style: const TextStyle(
                                color: textoBranco,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.password,
                                  color: textoCinzaClaro,
                                ),
                                filled: true,
                                fillColor: fundoSecundario,
                                hintText: 'Password',
                                hintStyle: RAJDHANI(
                                  fontSize: 20,
                                  color: textoCinzaClaro,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.length < 8) {
                                  return 'senha invalida';
                                } else {
                                  return null;
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton(
                            onPressed: () {
                              _loginProvider.login();
                              context.go('/HomePage');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: laranjaVibrante,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                            child: Text(
                              'LOG IN',
                              style: ORBITRON(
                                fontSize: 20,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: RAJDHANI(
                              fontSize: 20,
                              color: textoBranco,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            children: [
                              const Expanded(
                                  child: Divider(
                                color: Colors.white70,
                                thickness: 1,
                                endIndent: 10,
                              )),
                              Text(
                                'or',
                                style:
                                    ROBOTO(color: Colors.white70, fontSize: 20),
                              ),
                              const Expanded(
                                  child: Divider(
                                color: Colors.white70,
                                thickness: 1,
                                indent: 10,
                              )),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: fundoSecundario,
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.80,
                                  30)),
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                            size: 20,
                          ),
                          iconAlignment: IconAlignment.start,
                          label: const Text('Continue with google'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: fundoSecundario,
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.80,
                                  30)),
                          icon: const FaIcon(
                            FontAwesomeIcons.apple,
                            color: Colors.white70,
                            size: 20,
                          ),
                          iconAlignment: IconAlignment.start,
                          label: const Text('Sing in with Apple'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: ROBOTO(
                                color: textoBranco,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Sign Up',
                                style: ROBOTO(
                                  color: laranjaVibrante,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
