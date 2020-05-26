import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import './EmailMessageV1.dart';
import './EmailRecipientV1.dart';
import './IEmailClientV1.dart';

class EmailNullClientV1 implements IEmailClientV1 {
  @override
  Future sendMessage(String correlationId, EmailMessageV1 message,
      ConfigParams parameters) async {
    return null;
  }

  @override
  Future sendMessageToRecipient(
      String correlationId,
      EmailRecipientV1 recipient,
      EmailMessageV1 message,
      ConfigParams parameters) async {
    return null;
  }

  @override
  Future sendMessageToRecipients(
      String correlationId,
      List<EmailRecipientV1> recipients,
      EmailMessageV1 message,
      ConfigParams parameters) async {
    return null;
  }
}
