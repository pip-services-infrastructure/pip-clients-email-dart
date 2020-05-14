
import 'dart:async';

import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';

import 'EmailMessageV1.dart';
import 'EmailRecipientV1.dart';
import 'IEmailClientV1.dart';

class EmailHttpClientV1 extends CommandableHttpClient
    implements IEmailClientV1 {
  ConfigParams _defaultParameters;
  EmailHttpClientV1([dynamic config]) : super('v1/email') {
    var thisConfig = ConfigParams.fromValue(config);
    this._defaultParameters = thisConfig.getSection('parameters');
    if (config != null) this.configure(thisConfig);
  }
  
  Future<void> sendMessage(String correlationId, EmailMessageV1 message, ConfigParams parameters) async {
    parameters = this._defaultParameters.override(parameters);
    this.callCommand('send_message', correlationId, {'message': message, 'parameters': parameters});
  }

  Future<void> sendMessageToRecipient(String correlationId, EmailRecipientV1 recipient, EmailMessageV1 message, ConfigParams parameters) async {
    parameters = this._defaultParameters.override(parameters);
    this.callCommand(
        'send_message_to_recipient',
        correlationId,
        {'recipient': recipient, 'message': message, 'parameters': parameters});
  }

  Future<void> sendMessageToRecipients(String correlationId, List<EmailRecipientV1> recipients, EmailMessageV1 message, ConfigParams parameters) async {
    parameters = this._defaultParameters.override(parameters);
    this.callCommand(
        'send_message_to_recipients',
        correlationId,
        {
          'recipients': recipients,
          'message': message,
          'parameters': parameters
        });
  }
}
