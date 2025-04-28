module MyobAdvanced
  module Api
    module Model
      class PxObjectsCrBaccount < Base
        def model_route
          'PX_Objects_CR_BAccount'
        end

        def self.field_id
          'BAccountID'
        end

        def self.dac?
          true
        end
      end
    end
  end
end
