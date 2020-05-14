
import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../../pip_clients_email.dart';

abstract class IEmailClientV1 {
  Future sendMessage(String correlationId, EmailMessageV1 message, ConfigParams parameters);
  Future sendMessageToRecipient(String correlationId, EmailRecipientV1 recipient, EmailMessageV1 message, ConfigParams parameters);
  Future sendMessageToRecipients(String correlationId, List<EmailRecipientV1> recipients, EmailMessageV1 message, ConfigParams parameters);
}
