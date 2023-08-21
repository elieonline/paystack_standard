
### Paystack Standard Flutter Package
Paystack Standard simplifies the  Paystack integration - without exposing your PUB_KEY.
This is done using [Paystack Redirect](https://paystack.com/docs/payments/accept-payments/#redirect).

## Features
- All payment methods offered by paystack

## Getting started
## Installation
```dart
flutter pub add paystack_standard
```
## Usage
#### Initialise Transaction
This is done from your backend server using your `SECRET-KEY` as shown. [ref](https://paystack.com/docs/api/transaction/#initialize)

```node

const https = require('https')

const params = JSON.stringify({
  "email": "customer@email.com",
  "amount": "20000"
})

const options = {
  hostname: 'api.paystack.co',
  port: 443,
  path: '/transaction/initialize',
  method: 'POST',
  headers: {
    Authorization: 'Bearer SECRET_KEY',
    'Content-Type': 'application/json'
  }
}

const req = https.request(options, res => {
  let data = ''

  res.on('data', (chunk) => {
    data += chunk
  });

  res.on('end', () => {
    console.log(JSON.parse(data))
  })
}).on('error', error => {
  console.error(error)
})

req.write(params)
req.end()
```

#### Sample Response
```node

{
  "status": true,
  "message": "Authorization URL created",
  "data": {
    "authorization_url": "https://checkout.paystack.com/0peioxfhpn",
    "access_code": "0peioxfhpn",
    "reference": "7PVGX8MEk85tgeEpVDtD"
  }
}

```

An `authorization_url` is returned - your backend server should send this to the front end/client to checkout.

## NB: Please ensure to set your redirect url when initialising the paystack transaction.

#### Checkout/Payment
The `authorization_url` sent from your backend server is used as the only parameter to `Paystack Standard` interface.
The `PaystackStandard.checkout` method returns type `CheckoutResponse` which contains a `success - bool`, and the transaction `reference`.

```dart

PaystackStandard(context).checkout(checkoutUrl: "<authorization_url>").then((response){
  // here check for success - verify transaction status with your backend server
});

```

## ScreenShots
NB: 
