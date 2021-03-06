import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_components/pip_services3_components.dart';
//import 'package:pip_services_email/pip_services_email.dart';
import 'package:test/test.dart';

import 'package:pip_clients_email/pip_clients_email.dart';
import 'EmailClientFixtureV1.dart';

var httpConfig = ConfigParams.fromTuples([
  'connection.protocol',
  'http',
  'connection.host',
  'localhost',
  'connection.port',
  8080
]);

void main() {
  group('EmailHttpClientV1', () {
    //EmailHttpServiceV1 service;
    EmailHttpClientV1 client;
    EmailClientFixtureV1 fixture;

    setUp(() async {
      var logger = ConsoleLogger();
      client = EmailHttpClientV1();
      client.configure(httpConfig);

      var references = References.fromTuples([
        Descriptor('pip-services', 'logger', 'console', 'default', '1.0'),
        logger,
        Descriptor('pip-services-email', 'client', 'http', 'default', '1.0'),
        client
      ]);

      client.setReferences(references);
      fixture = EmailClientFixtureV1(client);
      await client.open(null);
    });

    tearDown(() async {
      await client.close(null);
      await Future.delayed(Duration(milliseconds: 2000));
    });

    test('Send Email to Address', () async {
      await fixture.testSendEmailToAddress();
    });

    test('Send Email to Recipients', () async {
      await fixture.testSendEmailToRecipients();
    });
  });
}
