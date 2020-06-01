import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services_email/pip_services_email.dart';
import 'package:test/test.dart';

import 'package:pip_clients_email/pip_clients_email.dart';
import './EmailClientFixtureV1.dart';

void main() {
  group('EmailDirectClientV1', () {
    EmailDirectClientV1 client;
    EmailClientFixtureV1 fixture;

    setUp(() async {
      var logger = ConsoleLogger();
      var controller = EmailController();
      controller.configure(ConfigParams.fromTuples(['options.disabled', true]));

      var references = References.fromTuples([
        Descriptor('pip-services', 'logger', 'console', 'default', '1.0'),
        logger,
        Descriptor(
            'pip-services-email', 'controller', 'default', 'default', '1.0'),
        controller,
      ]);
      controller.setReferences(references);

      client = EmailDirectClientV1();
      client.setReferences(references);

      fixture = EmailClientFixtureV1(client);

      await client.open(null);
    });

    tearDown(() async {
      await client.close(null);
    });

    test('Send Email to Address', () async {
        await fixture.testSendEmailToAddress();
    });

    test('Send Email to Recipients', () async {
        await fixture.testSendEmailToRecipients();
    });
  });
}
