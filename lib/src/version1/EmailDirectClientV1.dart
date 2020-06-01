import 'dart:async';

import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_clients_email/pip_clients_email.dart';

import 'package:pip_services_email/pip_services_email.dart';
import 'IEmailClientV1.dart';

class EmailDirectClientV1 extends DirectClient<dynamic>
    implements IEmailClientV1 {
  ConfigParams _defaultParameters;

  EmailDirectClientV1([dynamic config]) : super() {
    dependencyResolver.put('controller',
        Descriptor('pip-services-email', 'controller', '*', '*', '*'));
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
    var timing = instrument(correlationId, 'email.send_message');
    var result =
        await controller.sendMessage(correlationId, message, parameters);
    timing.endTiming();
    return result;
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
    var timing = instrument(correlationId, 'email.send_message_to_recipient');
    var result = await controller.sendMessageToRecipient(
        correlationId, recipient, message, parameters);
    timing.endTiming();
    return result;
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
    var timing = instrument(correlationId, 'email.send_message_to_recipients');
    var result = await controller.sendMessageToRecipients(
        correlationId, recipients, message, parameters);
    timing.endTiming();
    return result;
  }
}
