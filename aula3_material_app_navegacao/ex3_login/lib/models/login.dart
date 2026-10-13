/// Armazena as credenciais digitadas e sabe validá-las.
class Login {
  final String username;
  final String password;

  const Login({required this.username, required this.password});

  bool get isValid => username == 'admin' && password == '1234';
}
