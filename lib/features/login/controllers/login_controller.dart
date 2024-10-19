import 'package:car_workshop_app/features/login/services/login_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController implements GetxService {
  final LoginService loginService;
  LoginController({required this.loginService});
}