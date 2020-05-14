
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services_email/pip_services_email.dart';
import 'package:test/test.dart';

import 'package:pip_clients_email/pip_clients_email.dart';
import 'EmailClientFixtureV1.dart';

var httpConfig = ConfigParams.fromTuples([
    "connection.protocol", "http",
    "connection.host", "localhost",
    "connection.port", 3000
]);

void main() {
group('EmailHttpClientV1', () {
    EmailHttpServiceV1 service;
    EmailHttpClientV1 client;
    EmailClientFixtureV1 fixture;

    setUp(() async {
        var logger = ConsoleLogger();
        var controller = EmailController();
        controller.configure(ConfigParams.fromTuples([
            "options.disabled", true
        ]));

        service = EmailHttpServiceV1();
        service.configure(httpConfig);

        var references = References.fromTuples([
            Descriptor('pip-services', 'logger', 'console', 'default', '1.0'), logger,
            Descriptor('pip-services-email', 'controller', 'default', 'default', '1.0'), controller,
            Descriptor('pip-services-email', 'service', 'http', 'default', '1.0'), service
        ]);

        controller.setReferences(references);
        service.setReferences(references);

        client = EmailHttpClientV1();
        client.setReferences(references);
        client.configure(httpConfig);

        fixture = EmailClientFixtureV1(client);

        await service.open(null);
        await client.open(null);
    });
    
    tearDown(() async {
        client.close(null);
        service.close(null);
    });

    test('Send Email to Address', () async {
        await fixture.testSendEmailToAddress();
    });

    test('Send Email to Recipients', () async {
        await fixture.testSendEmailToRecipients();
    });
});
}