import '../../utils/results/data_result.dart';

///Veriyi uzak sunucudan çekmek için kullanılan servistir.
///Bu soyut sınıftan implement edilen somut sınıflar:
/// * `HttpRemoteDataManager`
abstract class RemoteDataService {
  ///Veriyi alırken ya da gönderirken kullanılan url
  String get baseUrl;

  ///Veri almak için kullanılır. [endpoint] ile hangi metota erişeceğimizi
  ///[query] ile şartımızı belirtiriz.
  Future<DataResult> get({
    required String endpoint,
    required String query,
    Duration timeout = const Duration(seconds: 10),
    Map<String, String>? header,
  });

  ///Veri göndermek için kullanılır. Gönderilecek veri [body] aracılığı ile
  ///[endpoint] kullanılarak iletilir.
  Future<DataResult> post({
    required String endpoint,
    required Object body,
    Map<String, String>? header,
    Duration timeout = const Duration(seconds: 10),
  });
}
