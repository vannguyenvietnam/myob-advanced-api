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

        def self.field_name
          'CustomerName'
        end
      end
    end
  end
end
