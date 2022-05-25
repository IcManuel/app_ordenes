import 'package:app_ordenes/domains/blocs/perfil_bloc.dart';
import 'package:app_ordenes/domains/utils/preferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Preferencias pref = Preferencias();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), navegar);
  }

  navegar() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    pref.versionApp = packageInfo.version;
    if (pref.token.isNotEmpty) {
      final perfilBloc = Provider.of<PerfilBloc>(context, listen: false);
      perfilBloc.usuFinal = pref.usuario!;
      await perfilBloc.loginBack(
          context, pref.usuario!.usuAlias, pref.usuario!.usuContrasena);
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * .6,
                height: size.width * .6,
                child: Image.asset(
                  'assets/images/MILA.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'MILA',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: size.height * .05),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
