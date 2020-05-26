import 'package:pip_clients_email/pip_clients_email.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

class EmailClientFixtureV1 {
  IEmailClientV1 _client;

  EmailClientFixtureV1(IEmailClientV1 client) {
    _client = client;
  }

  void testSendEmailToAddress() async {
    var message = EmailMessageV1(
        to: 'somebody@somewhere.com',
        subject: '{{subject}}',
        text: '{{text}}',
        html: '<p>{{text}}</p>');

    var parameters = ConfigParams.fromTuples(
        ['subject', 'Test Email To Address', 'text', 'This is just a test']);

    await _client.sendMessage(null, message, parameters);
  }

  void testSendEmailToRecipients() async {
    var message = EmailMessageV1(
        subject: 'Test Email To Recipient', text: 'This is just a test');

    var recipient = EmailRecipientV1(
        id: '1', email: 'somebody@somewhere.com', name: 'Test Recipient');

    await _client.sendMessageToRecipient(null, recipient, message, null);
  }
}
