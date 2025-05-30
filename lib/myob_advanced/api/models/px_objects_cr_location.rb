module MyobAdvanced
  module Api
    module Model
      class PxObjectsCrLocation < Base
        def model_route
          'PX_Objects_CR_Location'
        end

        def self.field_b_account_id
          'BAccountID'
        end

        def self.field_location_cd
          'LocationCD'
        end

        def self.dac?
          true
        end
      end
    end
  end
end
