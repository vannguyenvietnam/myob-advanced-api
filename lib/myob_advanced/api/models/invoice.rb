module MyobAdvanced
  module Api
    module Model
      class Invoice < Base
        def model_route
          'SalesInvoice'
        end
      end
    end
  end
end