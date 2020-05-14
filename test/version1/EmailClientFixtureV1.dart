import 'dart:async';

import 'package:pip_clients_email/pip_clients_email.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

class EmailClientFixtureV1 {
    IEmailClientV1 _client;
    
    EmailClientFixtureV1(IEmailClientV1 client) {
        this._client = client;
    }

    Future<void> testSendEmailToAddress() async {
        var message = EmailMessageV1()..fromJson({
            'to': 'somebody@somewhere.com',
            'subject': '{{subject}}',
            'text': '{{text}}',
            'html': '<p>{{text}}</p>'
        });

        var parameters = ConfigParams.fromTuples([
            'subject', 'Test Email To Address',
            'text', 'This is just a test'
        ]);

        await this._client.sendMessage(null, message, parameters);
    }

    Future<void> testSendEmailToRecipients() async {
        var message = EmailMessageV1()..fromJson({
            'subject': 'Test Email To Recipient',
            'text': 'This is just a test'
        });

        var recipient = EmailRecipientV1()..fromJson({
            'id': '1',
            'email': 'somebody@somewhere.com',
            'name': 'Test Recipient'
        });

        await this._client.sendMessageToRecipient(null, recipient, message, null);
    }
        
}
