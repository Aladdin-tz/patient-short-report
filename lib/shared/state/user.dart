import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  late User? user;

  Future init() async {
    User? localUser = await User.getUserFromStorage();

    if (localUser == null) {
      localUser = await User.getUserFromOnline();
      await localUser?.save();
    }

    user = localUser;
  }
}
