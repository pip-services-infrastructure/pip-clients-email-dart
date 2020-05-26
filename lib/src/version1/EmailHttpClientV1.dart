import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';

import './EmailMessageV1.dart';
import './EmailRecipientV1.dart';
import './IEmailClientV1.dart';

class EmailHttpClientV1 extends CommandableHttpClient
    implements IEmailClientV1 {
  ConfigParams _defaultParameters;
  EmailHttpClientV1([dynamic config]) : super('v1/email') {
    var thisConfig = ConfigParams.fromValue(config);
    _defaultParameters = thisConfig.getSection('parameters');
    if (config != null) configure(thisConfig);
  }

  /// Send the message
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [message]              a message to be send.
  /// - [parameters]              an additional parameters to be send.
  @override
  Future sendMessage(String correlationId, EmailMessageV1 message,
      ConfigParams parameters) async {
    parameters = _defaultParameters.override(parameters);
    return callCommand('send_message', correlationId,
        {'message': message, 'parameters': parameters});
  }

  /// Send the message to recipient
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [recipient]              a recipient of the message.
  /// - [message]              a message to be send.
  /// - [parameters]              an additional parameters to be send.
  @override
  Future sendMessageToRecipient(
      String correlationId,
      EmailRecipientV1 recipient,
      EmailMessageV1 message,
      ConfigParams parameters) async {
    parameters = _defaultParameters.override(parameters);
    return callCommand('send_message_to_recipient', correlationId,
        {'recipient': recipient, 'message': message, 'parameters': parameters});
  }

  /// Send the message to recipients
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [recipients]              a recipients of the message.
  /// - [message]              a message to be send.
  /// - [parameters]              an additional parameters to be send.
  @override
  Future sendMessageToRecipients(
      String correlationId,
      List<EmailRecipientV1> recipients,
      EmailMessageV1 message,
      ConfigParams parameters) async {
    parameters = _defaultParameters.override(parameters);
    return callCommand('send_message_to_recipients', correlationId, {
      'recipients': recipients,
      'message': message,
      'parameters': parameters
    });
  }
}
