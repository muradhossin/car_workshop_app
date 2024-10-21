import 'package:car_workshop_app/core/utils.dart';
import 'package:car_workshop_app/features/admin/mechanics/services/admin_mechani_service.dart';
import 'package:car_workshop_app/features/auth/models/user_model.dart';
import 'package:get/get.dart';

class AdminMechanicController extends GetxController implements GetxService {
  final AdminMechanicService adminMechanicService;
  AdminMechanicController({required this.adminMechanicService});

  Stream<int> getMechanicsCount() {
    return adminMechanicService.getMechanicsCount();
  }

  Stream<List<UserModel>> getPendingMechanics() {
    return adminMechanicService.getPendingMechanics();
  }

  Stream<List<UserModel>> getApprovedMechanics() {
    return adminMechanicService.getApprovedMechanics();
  }

  Stream<List<UserModel>> getRejectedMechanics() {
    return adminMechanicService.getRejectedMechanics();
  }

  Future<void> updateMechanicStatus(UserModel mechanic, String status) async {
    try{
      await adminMechanicService.updateMechanicStatus(mechanic, status);
      showCustomSnacker('success', 'Mechanic status updated successfully', );
    } catch (e) {
      showCustomSnacker('error', 'Failed to update mechanic status',  isError: true);
    }

  }


}