# MYOB Advanced API

A Ruby gem for interacting with the MYOB Advanced API.

[![Gem Version](https://badge.fury.io/rb/myob-advanced-api.svg)](https://badge.fury.io/rb/myob-advanced-api)

[MYOB Advanced Api](https://github.com/vannguyenvietnam/myob-advanced-api) inherited the structure of [MYOB Api](https://github.com/davidlumley/myob-api) is an interface for accessing [MYOB](https://developer.myob.com/api/advanced/)'s Advanced instance.

## Installation

Add this line to your application's Gemfile:

    gem 'myob-advanced-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install myob-advanced-api

## Supported Models

### RESTful API Models

- Account
- Subaccount
- PaymentMethod
- Customer
- CustomerClass
- CustomerLocation
- Contact
- CustomerPaymentMethod
- Invoice
- SalesInvoice
- SalesOrder
- Payment
- Vendor
- VendorClass
- Bill
- Check

### OData DAC Models

- `PX_Objects_AP_APInvoice`
- `PX_Objects_AP_APPayment`
- `PX_Objects_AR_ARAdjust`
- `PX_Objects_AR_ARInvoice`
- `PX_Objects_AR_ARPayment`
- `PX_Objects_AR_Customer`
- `PX_Objects_CA_Cash_Account`
- `PX_Objects_CR_BAccount`
- `PX_Objects_CR_Contact`
- `PX_Objects_CR_Location`
- `PX_Objects_CS_Terms`
- `PX_Objects_GL_Account`
- `PX_Objects_GL_Branch`
- `PX_Objects_SO_SOOrder`
- `PX_Objects_CS_DAC_OrganizationBAccount`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
