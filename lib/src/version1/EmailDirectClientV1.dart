import 'dart:async';

import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services_email/pip_services_email.dart' as service;
import 'package:pip_clients_email/pip_clients_email.dart';

import 'EmailRecipientV1.dart';
import 'IEmailClientV1.dart';

class EmailDirectClientV1 extends DirectClient<dynamic>
    implements IEmailClientV1 {
  ConfigParams _defaultParameters;

  EmailDirectClientV1([dynamic config]) 
        : super() {
    this.dependencyResolver.put('controller',
        new Descriptor('pip-services-email', 'controller', '*', '*', '*'));
    var thisConfig = ConfigParams.fromValue(config);
    this._defaultParameters = thisConfig.getSection('parameters');
    if (config != null) this.configure(thisConfig);
  }

  Future<void> sendMessage(String correlationId, EmailMessageV1 message,
      ConfigParams parameters) async {
    
    parameters = this._defaultParameters.override(parameters);
    var timing = this.instrument(correlationId, 'email.send_message');

    await this.controller.sendMessage(correlationId, convertMessageToPublic(message), parameters);
    
    timing.endTiming();
  }

  Future<void> sendMessageToRecipient(
      String correlationId,
      EmailRecipientV1 recipient,
      EmailMessageV1 message,
      ConfigParams parameters) async {
    
    parameters = this._defaultParameters.override(parameters);
    var timing = this.instrument(correlationId, 'email.send_message_to_recipient');
    
    await this.controller.sendMessageToRecipient(
      correlationId, 
      convertRecipientToPublic(recipient), 
      convertMessageToPublic(message), 
      parameters);

    timing.endTiming();
  }

  Future<void> sendMessageToRecipients(
      String correlationId,
      List<EmailRecipientV1> recipients,
      EmailMessageV1 message,
      ConfigParams parameters) async {
    
    parameters = this._defaultParameters.override(parameters);
    var timing = this.instrument(correlationId, 'email.send_message_to_recipients');
    
    await this.controller.sendMessageToRecipients(
        correlationId, 
        recipients.map((e) => convertRecipientToPublic(e)).toList(), 
        convertMessageToPublic(message), parameters);
    
    timing.endTiming();
  }

  service.EmailMessageV1 convertMessageToPublic(EmailMessageV1 message)
  {
      return service.EmailMessageV1()..fromJson(message.toJson());
  }

  service.EmailRecipientV1 convertRecipientToPublic(EmailRecipientV1 recipient)
  {
      return service.EmailRecipientV1()..fromJson(recipient.toJson());
  }

}
