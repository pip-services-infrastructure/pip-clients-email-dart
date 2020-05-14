# Email Microservice Client SDK for Dart

This is a Node.js client SDK for [pip-services-email](https://github.com/pip-services-infrastructure/pip-services-email-dart) microservice.
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
await client.sendMessage(
    null,
    EmailMessageV1()..fromJson({ 
        'to': 'somebody@somewhere.com',
        'subject': 'Test',
        'text': 'This is a test message. Please, ignore it'
    }),
    ConfigParams.fromTuples([
        'subject', 'Test Email To Address',
        'text', 'This is just a test'
    ])
);
```

```dart
// Send email message to users
await client.sendMessageToRecipients(
    null,
    [
        EmailRecipientV1()..fromJson({ id: '123', email: 'user1@somewhere.com' }),
        EmailRecipientV1()..fromJson({ id: '321', email: 'user2@somewhere.com' })
    ],
    EmailMessageV1()..fromJson({ 
        'subject': 'Test',
        'text': 'This is a test message. Please, ignore it'
    }),
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
await client.sendMessage(
    null,
    EmailMessageV1()..fromJson({  
        'to': 'somebody@somewhere.com',
        'subject': File('./templates/message_subject.txt').readAsStringSync(),
        'text': File('./templates/message.txt').readAsStringSync(),
        'html': File('./templates/message.html').readAsStringSync(),
    }),
    ConfigParams.fromTuples([
        'user_name', 'Somebody',
        'today': DateTime.now().toIso8601String()
    ])
);
```

## Acknowledgements

This client SDK was created and currently maintained by *Sergey Seroukhov*.

