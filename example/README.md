# Examples for Email Delivery Microservice

This is a user account management microservice from Pip.Services library. 
* Registers users and creates their accounts
* Keeps key user descriptions and settings (about, location, language, theme, ...)

Define client configuration parameters that match the configuration of the microservice's external API
```dart
// Client configuration
var httpConfig = ConfigParams.fromTuples(
	"connection.protocol", "http",
	"connection.host", "localhost",
	"connection.port", 8080
);
```

Instantiate the client and open connection to the microservice
```dart
// Create the client instance
var client = EmailHttpClientV1();

// Configure the client
client.configure(httpConfig);

// Connect to the microservice
try{
  await client.open(null)
}catch() {
  // Error handling...
}       
// Work with the microservice
// ...
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

In the help for each class there is a general example of its use. Also one of the quality sources
are the source code for the [**tests**](https://github.com/pip-services-infrastructure/pip-clients-email-dart/tree/master/test).
