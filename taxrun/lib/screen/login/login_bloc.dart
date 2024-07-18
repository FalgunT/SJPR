import 'dart:async';

class LoginBloc {
  final _usernameController = StreamController<String>();
  final _passwordController = StreamController<String>();
  final _loginController = StreamController<void>();

  // Input streams
  StreamSink<String> get usernameSink => _usernameController.sink;

  StreamSink<String> get passwordSink => _passwordController.sink;

  StreamSink<void> get loginSink => _loginController.sink;

  // Output streams
  Stream<String> get usernameStream => _usernameController.stream;

  Stream<String> get passwordStream => _passwordController.stream;

  LoginBloc() {
    _loginController.stream.listen((_) {
      String? username;
      String? password;
      _usernameController.stream.listen((value) => username = value);
      _passwordController.stream.listen((value) => password = value);

      // Perform validation and login logic here
      if (username != null && password != null) {
        if (username == 'Username' && password == 'password') {
          // Successful login
          print('Login successful!');
        } else {
          // Failed login
          print('Login failed!');
        }
      }
    });
  }

  void dispose() {
    _usernameController.close();
    _passwordController.close();
    _loginController.close();
  }
}
