# <img src="https://github.com/pip-services/pip-services/raw/master/design/Logo.png" alt="Pip.Services Logo" style="max-width:30%"> <br> Email Microservice Client SDK for Dart

This is a Dart client SDK for [pip-services-email](https://github.com/pip-services-infrastructure/pip-services-email-dart) microservice.
It provides an easy to use abstraction over communication protocols:

* HTTP client
* Direct client for monolythic deployments
* Null client to be used in testing

In addition to the microservice functionality the client SDK supports message templates 
that can be configured by client user. 

<a name="links"></a> Quick Links:

* [Development Guide](doc/Development.md)
* [API Version 1](doc/NodeClientApiV1.md)

## Install

Add **pip-services3-commons-dart** and **pip_clients_email** packages
```dart
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_email/pip_clients_email.dart';
```

## Use

Define client configuration parameters that match configuration of the microservice external API
```dart
// Client configuration
var config = ConfigParams.fromTuples(
	"connection.protocol", "http",
	"connection.host", "localhost",
	"connection.port", 8080
);
```

Instantiate the client and open connection to the microservice
```dart
// Create the client instance
var client = EmailHttpClientV1(config);

// Connect to the microservice
await client.open(null);
    
    // Work with the microservice
    ...
});
```

Now the client is ready to perform operations
```dart
// Send email message to address
        var message = EmailMessageV1(to: 'somebody@somewhere.com',
            subject: '{{subject}}',
            text: '{{text}}',
            html: '<p>{{text}}</p>');

        var parameters = ConfigParams.fromTuples([
            'subject', 'Test Email To Address',
            'text', 'This is just a test'
        ]);

await client.sendMessage(
    null,
    message,
    parameters
);
```

```dart
// Send email message to users
var recipient1 = EmailRecipientV1(id: '1', email: 'user1@somewhere.com');
var recipient2 = EmailRecipientV1(id: '2', email: 'user2@somewhere.com');
var message = EmailMessageV1(subject: 'Test', 
                             text: 'This is a test message. Please, ignore it');
await client.sendMessageToRecipients(
    null,
    [
        recipient1,
        recipient2
    ],
    message,
    null
);
```

To use templates for sent messages you need to put template files
under configured template folder. Inside template you shall use &lt;%= property %&gt; syntax
to insert properties from provided **content** defined in client configuration and request parameters.

Example of **message.txt** template
```text
Hello <%= user_name %>!

This is a test message from <%= client_name %> sent on <%= today %>.
Please, ignore it.
```

Example of **message.html** template
```html
Hello <%= user_name %>!
<p>
This is a test message from <%= client_name %> sent on <%= today %>. 
<br/>
Please, ignore it.
</p>
```

Now you can send a message using the templates stored in files. 
**subjectTemplate**, **textTemplate** and **htmlTemplate** parameters shall contain the template file paths.
Client will automatically load their content and parse.

```dart
// Send email message to address using template
var message = EmailMessageV1(to: 'somebody@somewhere.com', 
                             subject: File('./templates/message_subject.txt').readAsStringSync(), 
                             text: File('./templates/message.txt').readAsStringSync(),
                             html: File('./templates/message.html').readAsStringSync());
var parameters = ConfigParams.fromTuples([
        'user_name', 'Somebody',
        'today': DateTime.now().toIso8601String()
    ]);
await client.sendMessage(
    null,
    message,
    parameters
);
```

This microservice was created and currently maintained by
- **Sergey Seroukhov**
- **Denis Kuznetsov**
- **Nuzhnykh Egor**.