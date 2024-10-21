import 'package:car_workshop_app/features/admin/mechanics/services/admin_mechani_service.dart';
import 'package:get/get.dart';

class AdminMechanicController extends GetxController implements GetxService {
  final AdminMechanicService adminMechanicService;
  AdminMechanicController({required this.adminMechanicService});

  Stream<int> getMechanicsCount() {
    return adminMechanicService.getMechanicsCount();
  }
}