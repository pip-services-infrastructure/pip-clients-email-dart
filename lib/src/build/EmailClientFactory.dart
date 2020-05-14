
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_components/pip_services3_components.dart';

import '../version1/version1.dart';

class EmailClientFactory extends Factory {
  // static Descriptor Descriptor = Descriptor(
  //     "pip-services-email", "factory", "default", "default", "1.0");
  static var NullClientV1Descriptor = Descriptor("pip-services-email", "client", "null", "default", "1.0");
  static var DirectClientV1Descriptor = Descriptor("pip-services-email", "client", "direct", "default", "1.0");
  static var HttpClientV1Descriptor = Descriptor("pip-services-email", "client", "http", "default", "1.0");

  EmailClientFactory() : super() {
    this.registerAsType(EmailClientFactory.NullClientV1Descriptor, EmailNullClientV1);
    this.registerAsType(EmailClientFactory.DirectClientV1Descriptor, EmailDirectClientV1);
    this.registerAsType(EmailClientFactory.HttpClientV1Descriptor, EmailHttpClientV1);
  }
}
