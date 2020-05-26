import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_components/pip_services3_components.dart';

import '../version1/version1.dart';

class EmailClientFactory extends Factory {
  static final NullClientV1Descriptor =
      Descriptor('pip-services-email', 'client', 'null', 'default', '1.0');
  static final DirectClientV1Descriptor =
      Descriptor('pip-services-email', 'client', 'direct', 'default', '1.0');
  static final HttpClientV1Descriptor =
      Descriptor('pip-services-email', 'client', 'http', 'default', '1.0');

  EmailClientFactory() : super() {
    registerAsType(
        EmailClientFactory.NullClientV1Descriptor, EmailNullClientV1);
    registerAsType(
        EmailClientFactory.DirectClientV1Descriptor, EmailDirectClientV1);
    registerAsType(
        EmailClientFactory.HttpClientV1Descriptor, EmailHttpClientV1);
  }
}
