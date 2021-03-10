import 'dart:io';
import 'package:bookservice/constanc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app.dart';
part 'auth.dart';
part 'order.dart';
part 'user.dart';
part 'contract.dart';
part 'job.dart';
part 'address.dart';
part 'image.dart';

part 'comment.dart';

part 'client.g.dart';

// ignore_for_file: non_constant_identifier_names
  class CacheService<T> {
  static CacheService get instance => CacheService._();

  CacheService._();

  Future<String> getLanguage() async {
    return SharedPreferences.getInstance().then((sp) {
      return sp.getString('language') ?? 'en';
    });
  }

  Future<bool> setLanguage(language) async {
    return SharedPreferences.getInstance().then((sp) {
      return sp.setString('language', language);
    });
  }

  Future<String> getToken() async {
    return SharedPreferences.getInstance().then((sp) {
      return sp.getString('token') ?? 'unknow';
    });
  }

  Future<bool> setToken(token) async {
    return SharedPreferences.getInstance().then((sp) {
      return sp.setString('token', 'token ' + token);
    });
  }

  Future<bool> clearToken() async {
    return SharedPreferences.getInstance().then((sp) {
      return sp.remove('token');
    });
  }

  Future<String> getAdvertising() {
    return SharedPreferences.getInstance().then((sp) {
      return sp.getString('ad');
    });
  }

  Future<bool> setAdvertising(ad) {
    return SharedPreferences.getInstance().then((sp) {
      return sp.setString('ad', ad);
    });
  }
}

@RestApi(baseUrl: Constant.Host)
abstract class RestService {
  static RestService get instance => _RestService(Dio(BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ))
        ..interceptors
            .add(new InterceptorsWrapper(onRequest: (Options options) async {
          var token = await CacheService.instance.getToken();
          options.headers['Authorization'] = token;
         // print("afnan hassan ");
          print(token);
          return options;
        }, onResponse: (Response response) {
          if (response?.data is Map) {
            response.data = response?.data['result'];
            print(response.data);
          }
          return response;
        }, onError: (DioError e) async {
          if (e?.response?.statusCode == 400) {
            var data = e?.response?.data['result'];
            if (data != null && data is Map) {
              data.forEach((k, v) {
                if (v is Iterable) {
                  data[k] = v.join('\n');
                } else {
                  data[k] = v;
                }
              });
              e?.response?.data = data;
            }
          } else if (e?.response?.statusCode == 401) {
            CacheService.instance.clearToken();
          }

          if (e?.response?.statusCode == 500) {
            e?.response?.data = {'non_field_errors': e.message};
          }
          return e;
        })));

  @GET('/apps/')
  Future<List<App>> getApps({@Queries() Map<String, dynamic> query});

  @GET('/users/info/')
  Future<User> getInfo({@Queries() Map<String, dynamic> query});

  @GET('/profileDetails/info/')
  Future<ProfileDetails> getProfileDetail({@Queries() Map<String, dynamic> query});

  @PATCH('/users/{id}/')
  Future<User> uploadPhoto(@Path() String id, @Part() File photo);

  @PATCH('/users/{id}/')
  Future<User> updateUser(
      @Path() String id, @Body() Map<String, dynamic> playload);

  @GET('/contracts/')
  Future<List<Contract>> getContracts({@Queries() Map<String, dynamic> query});

  @GET('/address/')
  Future<List<Address>> getAddressList({@Queries() Map<String, dynamic> query});

  @GET('/address/{id}/')
  Future<Address> getAddress(@Path() String id);

  @PATCH('/address/{id}/')
  Future<Address> updateAddress(@Path() String id, @Body() Address data);

  @POST('/address/')
  Future<Address> postAddress(@Body() Address data);

  @DELETE('/address/{id}/')
  Future<void> deleteAddress(@Path() String id);

  @GET('/orders/')
  Future<OrderList> getOrders({@Queries() Map<String, dynamic> query});

  @GET('/orders/{id}/')
  Future<Order> getOrder(@Path() String id);

  @POST('/orders/')
  Future<Order> postOrder(@Body() Map<String, dynamic> playload);

  @PATCH('/orders/{id}/')
  Future<Address> updateOrder(@Path() String id, @Body() Order data);

  @POST('/images/')
  Future<SourceImage> postImage(@Part() File image, @Part() String tag,
      @Part() String content_type, @Part() int object_id);

  @GET('/images/')
  Future<List<SourceImage>> getImages({@Queries() Map<String, dynamic> query});

  @POST('/comments/')
  Future<Comment> postComment(@Body() Map<String, dynamic> playload);

  @GET('/comments/')
  Future<List<Comment>> getComments({@Queries() Map<String, dynamic> query});

  @GET('/jobs/')
  Future<JobList> getJobs({@Queries() Map<String, dynamic> query});

  @POST('/auth/phone/generate/')
  Future<Otp> phoneGenerate(@Body() Map<String, dynamic> playload);

  @POST('/auth/phone/validate/')
  Future<Token> phoneValidate(@Body() Map<String, dynamic> playload);

  @POST('auth/email/code/generate/')
  Future<EmailAddress> emailGenerate(@Body() Map<String, dynamic> playload);

  @POST('auth/email/code/validate/')
  Future<EmailAddress> emailValidate(@Body() Map<String, dynamic> playload);
}

class RestServiceExtra {
  static RestServiceExtra get instance => RestServiceExtra._();

  RestServiceExtra._();

  Stream<String> getAdvertising() {
    return Stream<String>.fromFutures([
      CacheService.instance.getAdvertising(),
      RestService.instance.getApps(query: {'tag': 0}).then((data) {
        var _data = data.isNotEmpty ? data?.last?.image?.advertising : null;
        CacheService.instance.setAdvertising(_data);
        return _data;
      })
    ]).delay(Duration(seconds: 3)).distinct();
  }
}
