# Client API (version 1) <br/> Email Delivery Microservices Client SDK for Node.js

Node.js client API for Email delivery microservice is a thin layer on the top of
communication protocols. It hides details related to specific protocol implementation
and provides high-level API to access the microservice for simple and productive development.

* [Installation](#install)
* [Getting started](#get_started)
* [EmailMessageV1 class](#class2)
* [EmailRecipientV1 class](#class3)
* [IEmailClientV1 interface](#interface)
    - [sendMessage()](#operation9)
    - [sendMessageToRecipient()](#operation10)
    - [sendMessageToRecipient()](#operation11)
* [EmailHttpClientV1 class](#client_http)
* [EmailSenecaClientV1 class](#client_seneca)
* [EmailDirectClientV1 class](#client_direct)
* [EmailNullClientV1 class](#client_null)
* [Message Templates](#templates)

## <a name="install"></a> Installation

To work with the client SDK add dependency into package.json file:

```javascript
{
    ...
    "dependencies": {
        ....
        "pip-clients-email-node": "^1.0.*",
        ...
    }
}
```

Then download the dependency using **npm**:

```javascript
# Installing dependencies
npm install

# Updating dependencies
npm update
```

## <a name="get_started"></a> Getting started

This is a simple example on how to work with the microservice using REST client:

```javascript
// Get Client SDK for Version 1 
var sdk = new require('pip-clients-email-node');

// Client configuration
var config = {
    parameters: {
        server_url: 'http://localhost:3000',
        client_url: 'http://localhost:8000',
        client_name: 'PipServices Sample',
        welcome_message: 'Congratulations with your signup in <%= clientName %>!',
        signature: 'Sincerely, <%= clientName %> Team'
    }
    connection: {
        protocol: 'http',
        host: 'localhost', 
        port: 8005
    }
};

// Create the client instance
var client = sdk.EmailHttpClientV1(config);

// Open client connection to the microservice
client.open(null, function(err) {
    if (err) {
        console.error(err);
        return; 
    }
    
    console.log('Opened connection');
        
    // Send email message to address
    client.sendMessage(
        null,
        { 
            to: 'somebody@somewhere.com',
            subject: 'Test',
            text: 'This is a test message. Please, ignore it'
        },
        null,
        function (err) {
            if (err) console.error(err);
            else console.log('Email message was successfully sent');
        }
    );

    // Send email message to address using template
    client.sendMessage(
        null,
        { 
            to: 'somebody@somewhere.com',
            subject: 'Test message for {{ user_name }}',
            text: 'This is a test message from {{ client_name }} sent on {{ today }}.'
        },
        {
            user_name: 'Somebody',
            today: new Date.toISOString()
        },
        function (err) {
            if (err) console.error(err);
            else console.log('Email message was successfully sent');
        }
    );
    
});
```

## Data types

### <a name="class1"></a> EmailMessageV1 class

Message object with sender and recipient addresses, subject and content

**Properties:**
    - to: string or [string] - one or several addresses of message recipient
    - from: string - (optional) sender address
    - cc: string or [string] - (optional) one or several addresses of CC: recipients
    - bcc: string or [string] - (optional) one or several addresses of BCC: recipients
    - reply_to: string - (optional) response email address
    - subject: string - (optional) message subject
    - text: string - (optional) message plain text body 
    - html: string - (optional) message html body

### <a name="class2"></a> EmailRecipientV1 class

Recipient properties. If some properties are not set, the service
tries to restore them from email settings.

**Properties:**
- id: string - unique user id
- name: string - (optional) user full name
- email: string - (optional) primary user email
- language: string - (optional) user preferred language

## <a name="interface"></a> IEmailClientV1 interface

If you are using Typescript, you can use IEmailClientV1 as a common interface across all client implementations. 
If you are using plain Javascript, you shall not worry about IEmailClient interface. You can just expect that
all methods defined in this interface are implemented by all client classes.

```javascript
interface IEmailClientV1 {
    sendMessage(correlationId, message, parameters, callback);
    sendMessageToRecipient(correlationId, recipient, message, parameters, callback);
    sendMessageToRecipients(correlationId, recipients, message, parameters, callback);
}
```

### <a name="operation1"></a> sendMessage(correlationId, message, parameters, callback)

Sends email message to specified address or addresses

**Arguments:**
- correlationId: string - id that uniquely identifies transaction
- message: EmailMessageV1 - message to be sent
- parameters: Object - (optional) template parameters
- callback: (err) => void - callback function
  - err: Error - occured error or null for success

### <a name="operation2"></a> sendMessageToRecipient(correlationId, recipient, message, parameters, callback)

Sends email message to specified recipient

**Arguments:**
- correlationId: string - id that uniquely identifies transaction
- recipient: EmailRecipientV1 - recipient properties, including id
- message: EmailMessageV1 - message to be sent
- parameters: Object - (optional) template parameters
- callback: (err) => void - callback function
  - err: Error - occured error or null for success

### <a name="operation3"></a> sendMessageToRecipients(correlationId, recipients, message, parameters, callback)

Sends email message to multiple recipients

**Arguments:**
- correlationId: string - id that uniquely identifies transaction
- recipients: EmailRecipientV1[] - array of recipient properties, including id
- message: EmailMessageV1 - message to be sent
- parameters: Object - (optional) template parameters
- callback: (err) => void - callback function
  - err: Error - occured error or null for success


## <a name="client_http"></a> EmailHttpClientV1 class

EmailHttpClientV1 is a client that implements HTTPprotocol

```javascript
class EmailHttpClientV1 extends CommandableHttpClient implements IEmailClientV1 {
    constructor(config?: any);
    setReferences(refs);
    open(correlationId, callback);
    close(correlationId, callback);
    sendMessage(correlationId, message, parameters, callback);
    sendMessageToRecipient(correlationId, recipient, message, parameters, callback);
    sendMessageToRecipients(correlationId, recipients, message, parameters, callback);
}
```

**Constructor config properties:** 
- parameters: Object - (optional) default parameters to augment content passed in each request
- connection: object - HTTP transport configuration options
  - protocol: string - HTTP protocol - 'http' or 'https' (default is 'http')
  - host: string - IP address/hostname binding (default is '0.0.0.0')
  - port: number - HTTP port number

## <a name="client_seneca"></a> EmailSenecaClientV1 class

EmailSenecaClientV1 is a client that implements Seneca protocol

```javascript
class EmailSenecaClientV1 extends CommandableSenecaClient implements IEmailClientV1 {
    constructor(config?: any);        
    setReferences(refs);
    open(correlationId, callback);
    close(correlationId, callback);
    sendMessage(correlationId, message, parameters, callback);
    sendMessageToRecipient(correlationId, recipient, message, parameters, callback);
    sendMessageToRecipients(correlationId, recipients, message, parameters, callback);
}
```

**Constructor config properties:** 
- parameters: Object - (optional) default parameters to augment content passed in each request
- connection: object - (optional) Seneca transport configuration options. See http://senecajs.org/api/ for details.
  - protocol: string - Seneca transport type 
  - host: string - IP address/hostname binding (default is '0.0.0.0')
  - port: number - Seneca port number

## <a name="client_direct"></a> EmailDirectClientV1 class

EmailDirectClientV1 is a client that calls controller from the same container.
It is intended to be used in monolythic deployments.

```javascript
class EmailDirectClientV1 extends DirectClient implements IEmailClientV1 {
    constructor();
    setReferences(refs);
    open(correlationId, callback);
    close(correlationId, callback);
    sendMessage(correlationId, message, parameters, callback);
    sendMessageToRecipient(correlationId, recipient, message, parameters, callback);
    sendMessageToRecipients(correlationId, recipients, message, parameters, callback);
}
```

## <a name="client_null"></a> EmailNullClientV1 class

EmailNullClientV1 is a dummy client that mimics the real client but doesn't call a microservice. 
It can be useful in testing scenarios to cut dependencies on external microservices.

```javascript
class EmailNullClientV1 implements IEmailClientV1 {
    constructor();
    sendMessage(correlationId, message, parameters, callback);
    sendMessageToRecipient(correlationId, recipient, message, parameters, callback);
    sendMessageToRecipients(correlationId, recipients, message, parameters, callback);
}
```

## <a name="templates"></a> Message Templates

Templates use handlebars syntax and can be assigned corresponding message properties.
Inside, it shall use {{ content_prop }} syntax to include properties from **parameters** argument.

Example of the html template
```html
Dear {{ name }},
<p/>
{{ welcome_message }}
<p/>
To continue, please, verify your email address. Your verification code is {{ code }}.
<p/>
Click on the 
<a href="{{ client_url }}/#/verify_email?server_url={{ server_url }}&email={{ email }}&code={{ code }}">link</a>
to complete verification procedure
<p/>
---<br/>
{{ signature }}
```