import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UsedMarketController extends GetxController implements GetxService {
  XFile _pickedFile;
  bool _isLoading = false;

  XFile get pickedFile => _pickedFile;

  bool get isLoading => _isLoading;

  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
  }

  void initData() {
    _pickedFile = null;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }
}
