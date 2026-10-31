import 'dart:convert';
import 'package:http/http.dart' as http;

// Modelo de datos
class CloudUser {
  final int id;
  final String name;
  final String email;

  CloudUser({required this.id, required this.name, required this.email});

  factory CloudUser.fromJson(Map<String, dynamic> json) {
    return CloudUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

// Función asíncrona para consumir el servicio en la nube
Future<List<CloudUser>> fetchCloudUsers() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    // Si el servidor devuelve una respuesta OK, parseamos el JSON.
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => CloudUser.fromJson(user)).toList();
  } else {
    // Si la respuesta no fue OK, lanzamos un error.
    throw Exception('Error al conectar con el servicio en la nube');
  }
}