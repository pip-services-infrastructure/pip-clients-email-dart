import 'package:pip_clients_email/pip_clients_email.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services_email/pip_services_email.dart';

Future<void> main(List<String> argument) async {
  try {
    var correlationId = '123';
    var config = ConfigParams.fromTuples([
      'connection.type',
      'http',
      'connection.host',
      'localhost',
      'connection.port',
      8080
    ]);
    var client = EmailHttpClientV1();
    client.configure(config);
    var message = EmailMessageV1(
        to: 'somebody@somewhere.com',
        subject: '{{subject}}',
        text: '{{text}}',
        html: '<p>{{text}}</p>');

    var parameters = ConfigParams.fromTuples(
        ['subject', 'Test Email To Address', 'text', 'This is just a test']);
    await client.open(correlationId);
    // Send message
    await client.sendMessage(correlationId, message, parameters);

    await client.close(correlationId);
  } catch (ex) {
    print(ex);
  }
}
