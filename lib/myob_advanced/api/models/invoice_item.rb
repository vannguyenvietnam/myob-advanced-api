module MyobAdvanced
  module Api
    module Model
      class InvoiceItem < Base
        def model_route
          'Sale/Invoice/Item'
        end
      end
    end
  end
end