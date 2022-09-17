int addFunc(int a, int b) => a + b;

int subFunc(int a, int b) => a - b;

int multiFunc(int a, int b) => a * b;

class Validator {

  static String? isEmailEmpty(String email) {
    if (email.isEmpty) {
      return "Required";
    }

    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return "Enter Valid Email pls";
    }

    return null;
  }//end

  static String? isPasswordEmpty(String password) {
    if (password.isEmpty) {
      return "Required";
    }


    if (password.length < 8) {
      return "Enter Valid Password pls";
    }

    return null;
  }//end
}
