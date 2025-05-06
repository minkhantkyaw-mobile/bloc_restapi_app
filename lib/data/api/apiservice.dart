import 'package:bloc_restapi_app/data/model/contact.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'apiservice.g.dart';

@RestApi(baseUrl: 'https://6819c4321ac1155635063dee.mockapi.io/api')
abstract class ApiService {
  factory ApiService(Dio dio) => _ApiService(dio);

  @GET('')
  Future<List<Contact>> getContact();

  @POST('')
  Future<Contact> addContact(@Body() Contact contact);

  @PUT('{id}')
  Future<Contact> updateContact(@Path() String id, @Body() Contact contact);

  @DELETE('{id}')
  Future<Contact> deleteContact(@Path() String id);
}
