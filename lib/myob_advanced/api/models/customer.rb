module MyobAdvanced
  module Api
    module Model
      class Customer < Base
        def model_route
          'Customer'
        end

        def self.field_id
          'CustomerID'
        end
      end
    end
  end
end
