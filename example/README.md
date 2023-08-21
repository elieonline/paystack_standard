
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
![paystack_bank](https://github.com/sunday-okpoluaefe/paystack_standard/assets/63934292/54991b9f-3a77-4965-97c8-621ef6dbeb52)
![paystack_cancel](https://github.com/sunday-okpoluaefe/paystack_standard/assets/63934292/bc681e57-d3f6-4e6d-9d1f-26929fb611b2)
![paystack_card](https://github.com/sunday-okpoluaefe/paystack_standard/assets/63934292/b2a87c96-4e26-4a87-86bc-2fda63d840fd)
![paystack_home](https://github.com/sunday-okpoluaefe/paystack_standard/assets/63934292/6beb7c7a-2167-47ec-9265-9467e599d172)
![paystack_transfer](https://github.com/sunday-okpoluaefe/paystack_standard/assets/63934292/ee470895-dbc1-4b20-8dc6-11306fcb0d8b)
![paystack_ussd](https://github.com/sunday-okpoluaefe/paystack_standard/assets/63934292/b51d485c-3796-439e-8ff8-37214c96ffc0)

