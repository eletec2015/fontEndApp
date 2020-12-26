// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppImage _$AppImageFromJson(Map<String, dynamic> json) {
  return AppImage(
    full: json['full'] as String,
    banner: json['banner'] as String,
    advertising: json['advertising'] as String,
  );
}

Map<String, dynamic> _$AppImageToJson(AppImage instance) => <String, dynamic>{
      'full': instance.full,
      'banner': instance.banner,
      'advertising': instance.advertising,
    };

App _$AppFromJson(Map<String, dynamic> json) {
  return App(
    id: json['id'] as int,
    image: json['image'] == null
        ? null
        : AppImage.fromJson(json['image'] as Map<String, dynamic>),
    sorter: json['sorter'] as int,
    tag: json['tag'] as int,
    create_at: json['create_at'] as String,
  )..app_size = json['app_size'] as String;
}

Map<String, dynamic> _$AppToJson(App instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'sorter': instance.sorter,
      'tag': instance.tag,
      'app_size': instance.app_size,
      'create_at': instance.create_at,
    };

Otp _$OtpFromJson(Map<String, dynamic> json) {
  return Otp(
    json['phone_number'] as String,
  );
}

Map<String, dynamic> _$OtpToJson(Otp instance) => <String, dynamic>{
      'phone_number': instance.phone_number,
    };

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    json['id'] as int,
    json['last_login'] as String,
    json['token'] as String,
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'id': instance.id,
      'last_login': instance.last_login,
      'token': instance.token,
    };

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['id'] as int,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    user_id: json['user_id'] as int,
    contract: json['contract'] == null
        ? null
        : Contract.fromJson(json['contract'] as Map<String, dynamic>),
    contract_id: json['contract_id'] as int,
    orderID: json['orderID'] as String,
    images: (json['images'] as List)
        ?.map((e) =>
            e == null ? null : SourceImage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    jobs: (json['jobs'] as List)
        ?.map((e) => e == null ? null : Job.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    comments: (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    status: json['status'] as int,
    service: json['service'] as int,
    main_info: json['main_info'] as int,
    sub_info: json['sub_info'] as int,
    from_date: json['from_date'] as String,
    to_date: json['to_date'] as String,
    code: json['code'] as String,
    address: json['address'] as String,
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
    create_at: json['create_at'] as String,
    change_at: json['change_at'] as String,
    deleted: json['deleted'] as bool,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'user_id': instance.user_id,
      'contract': instance.contract,
      'contract_id': instance.contract_id,
      'orderID': instance.orderID,
      'images': instance.images,
      'jobs': instance.jobs,
      'comments': instance.comments,
      'status': instance.status,
      'service': instance.service,
      'main_info': instance.main_info,
      'sub_info': instance.sub_info,
      'from_date': instance.from_date,
      'to_date': instance.to_date,
      'code': instance.code,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'create_at': instance.create_at,
      'change_at': instance.change_at,
      'deleted': instance.deleted,
    };

OrderList _$OrderListFromJson(Map<String, dynamic> json) {
  return OrderList()
    ..totalCount = json['totalCount'] as int
    ..pageNo = json['pageNo'] as int
    ..data = (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrderListToJson(OrderList instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'pageNo': instance.pageNo,
      'data': instance.data,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as int
    ..username = json['username'] as String
    ..name = json['name'] as String
    ..first_name = json['first_name'] as String
    ..last_name = json['last_name'] as String
    ..is_staff = json['is_staff'] as bool
    ..is_active = json['is_active'] as bool
    ..is_superuser = json['is_superuser'] as bool
    ..email = json['email'] == null
        ? null
        : EmailAddress.fromJson(json['email'] as Map<String, dynamic>)
    ..role = json['role'] as int
    ..photo = (json['photo'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'is_staff': instance.is_staff,
      'is_active': instance.is_active,
      'is_superuser': instance.is_superuser,
      'email': instance.email,
      'role': instance.role,
      'photo': instance.photo,
    };

EmailAddress _$EmailAddressFromJson(Map<String, dynamic> json) {
  return EmailAddress()
    ..email = json['email'] as String
    ..verified = json['verified'] as bool;
}

Map<String, dynamic> _$EmailAddressToJson(EmailAddress instance) =>
    <String, dynamic>{
      'email': instance.email,
      'verified': instance.verified,
    };

Visit _$VisitFromJson(Map<String, dynamic> json) {
  return Visit()
    ..service = json['service'] as int
    ..count = json['count'] as int;
}

Map<String, dynamic> _$VisitToJson(Visit instance) => <String, dynamic>{
      'service': instance.service,
      'count': instance.count,
    };

Contract _$ContractFromJson(Map<String, dynamic> json) {
  return Contract()
    ..id = json['id'] as int
    ..contractID = json['contractID'] as String
    ..option = json['option'] as int
    ..issue_date = json['issue_date'] as String
    ..expiry_date = json['expiry_date'] as String
    ..address = json['address'] as String
    ..remark = json['remark'] as String
    ..visits = (json['visits'] as List)
        ?.map(
            (e) => e == null ? null : Visit.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'id': instance.id,
      'contractID': instance.contractID,
      'option': instance.option,
      'issue_date': instance.issue_date,
      'expiry_date': instance.expiry_date,
      'address': instance.address,
      'remark': instance.remark,
      'visits': instance.visits,
    };

ContractList _$ContractListFromJson(Map<String, dynamic> json) {
  return ContractList()
    ..totalCount = json['totalCount'] as int
    ..pageNo = json['pageNo'] as int
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Contract.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ContractListToJson(ContractList instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'pageNo': instance.pageNo,
      'data': instance.data,
    };

Job _$JobFromJson(Map<String, dynamic> json) {
  return Job()
    ..id = json['id'] as int
    ..jobID = json['jobID'] as String
    ..date = json['date'] as String
    ..card = json['card'] as String
    ..unit = json['unit'] as int
    ..remark = json['remark'] as String
    ..order_id = json['order_id'] as int;
}

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'id': instance.id,
      'jobID': instance.jobID,
      'date': instance.date,
      'card': instance.card,
      'unit': instance.unit,
      'remark': instance.remark,
      'order_id': instance.order_id,
    };

JobList _$JobListFromJson(Map<String, dynamic> json) {
  return JobList()
    ..totalCount = json['totalCount'] as int
    ..pageNo = json['pageNo'] as int
    ..data = (json['data'] as List)
        ?.map((e) => e == null ? null : Job.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$JobListToJson(JobList instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'pageNo': instance.pageNo,
      'data': instance.data,
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    id: json['id'] as int,
    defAddr: json['defAddr'] as bool,
    onMap: json['onMap'] as bool,
    model: json['model'] as int,
    style: json['style'] as int,
    city: json['city'] as String,
    community: json['community'] as String,
    street: json['street'] as String,
    building: json['building'] as String,
    roomNo: json['roomNo'] as String,
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
    address: json['address'] as String,
    user_id: json['user_id'] as int,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'defAddr': instance.defAddr,
      'onMap': instance.onMap,
      'model': instance.model,
      'style': instance.style,
      'city': instance.city,
      'community': instance.community,
      'street': instance.street,
      'building': instance.building,
      'roomNo': instance.roomNo,
      'lat': instance.lat,
      'lng': instance.lng,
      'address': instance.address,
      'user_id': instance.user_id,
    };

SourceImage _$SourceImageFromJson(Map<String, dynamic> json) {
  return SourceImage()
    ..id = json['id'] as int
    ..image = (json['image'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    )
    ..tag = json['tag'] as String
    ..content_type = json['content_type'] as String
    ..object_id = json['object_id'] as int;
}

Map<String, dynamic> _$SourceImageToJson(SourceImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'tag': instance.tag,
      'content_type': instance.content_type,
      'object_id': instance.object_id,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment()
    ..id = json['id'] as int
    ..comment = json['comment'] as String
    ..rating = json['rating'] as int
    ..read = json['read'] as bool
    ..image = json['image'] as Map<String, dynamic>
    ..create_at = json['create_at'] as String
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..child = (json['child'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..content_type = json['content_type'] as String
    ..object_id = json['object_id'] as int
    ..user_id = json['user_id'] as int;
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'rating': instance.rating,
      'read': instance.read,
      'image': instance.image,
      'create_at': instance.create_at,
      'user': instance.user,
      'child': instance.child,
      'content_type': instance.content_type,
      'object_id': instance.object_id,
      'user_id': instance.user_id,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestService implements RestService {
  _RestService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://hassanrehman.pythonanywhere.com/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getApps({query}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/apps/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => App.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  getInfo({query}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/users/info/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = User.fromJson(_result.data);
    return value;
  }

  @override
  uploadPhoto(id, photo) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(photo, 'photo');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.files.add(MapEntry(
        'photo',
        MultipartFile.fromFileSync(photo.path,
            filename: photo.path.split(Platform.pathSeparator).last)));
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/users/$id/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PATCH',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = User.fromJson(_result.data);
    return value;
  }

  @override
  updateUser(id, playload) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(playload, 'playload');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(playload ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/users/$id/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PATCH',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = User.fromJson(_result.data);
    return value;
  }

  @override
  getContracts({query}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/contracts/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Contract.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  getAddressList({query}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/address/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Address.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  getAddress(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/address/$id/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Address.fromJson(_result.data);
    return value;
  }

  @override
  updateAddress(id, data) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/address/$id/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PATCH',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Address.fromJson(_result.data);
    return value;
  }

  @override
  postAddress(data) async {
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/address/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Address.fromJson(_result.data);
    return value;
  }

  @override
  deleteAddress(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/address/$id/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }

  @override
  getOrders({query}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/orders/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = OrderList.fromJson(_result.data);
    return value;
  }

  @override
  getOrder(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/orders/$id/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }

  @override
  postOrder(playload) async {
    ArgumentError.checkNotNull(playload, 'playload');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(playload ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/orders/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }

  @override
  updateOrder(id, data) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/orders/$id/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PATCH',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Address.fromJson(_result.data);
    return value;
  }

  @override
  postImage(image, tag, content_type, object_id) async {
    ArgumentError.checkNotNull(image, 'image');
    ArgumentError.checkNotNull(tag, 'tag');
    ArgumentError.checkNotNull(content_type, 'content_type');
    ArgumentError.checkNotNull(object_id, 'object_id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.files.add(MapEntry(
        'image',
        MultipartFile.fromFileSync(image.path,
            filename: image.path.split(Platform.pathSeparator).last)));
    if (tag != null) {
      _data.fields.add(MapEntry('tag', tag));
    }
    if (content_type != null) {
      _data.fields.add(MapEntry('content_type', content_type));
    }
    if (object_id != null) {
      _data.fields.add(MapEntry('object_id', object_id.toString()));
    }
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/images/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SourceImage.fromJson(_result.data);
    return value;
  }

  @override
  getImages({query}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/images/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => SourceImage.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  postComment(playload) async {
    ArgumentError.checkNotNull(playload, 'playload');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(playload ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/comments/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Comment.fromJson(_result.data);
    return value;
  }

  @override
  getComments({query}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/comments/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Comment.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  getJobs({query}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('/jobs/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = JobList.fromJson(_result.data);
    return value;
  }

  @override
  phoneGenerate(playload) async {
    ArgumentError.checkNotNull(playload, 'playload');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(playload ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/auth/phone/generate/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Otp.fromJson(_result.data);
    return value;
  }

  @override
  phoneValidate(playload) async {
    ArgumentError.checkNotNull(playload, 'playload');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(playload ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/auth/phone/validate/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Token.fromJson(_result.data);
    return value;
  }

  @override
  emailGenerate(playload) async {
    ArgumentError.checkNotNull(playload, 'playload');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(playload ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'auth/email/code/generate/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EmailAddress.fromJson(_result.data);
    return value;
  }

  @override
  emailValidate(playload) async {
    ArgumentError.checkNotNull(playload, 'playload');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(playload ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'auth/email/code/validate/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EmailAddress.fromJson(_result.data);
    return value;
  }
}
