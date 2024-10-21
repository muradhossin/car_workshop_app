import 'package:car_workshop_app/features/mechanic/profile/services/mechanic_profile_service.dart';
import 'package:get/get.dart';

class MechanicProfileController extends GetxController implements GetxService {
  final MechanicProfileService mechanicProfileService;
  MechanicProfileController({required this.mechanicProfileService});

}