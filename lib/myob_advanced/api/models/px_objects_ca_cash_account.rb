module MyobAdvanced
  module Api
    module Model
      class PxObjectsCaCashAccount < Base
        def model_route
          'PX_Objects_CA_CashAccount'
        end

        def self.field_id
          'CashAccountCD'
        end

        def self.field_name
          'CashAccountCD'
        end

        def self.field_note_id
          'CashAccountCD'
        end

        def self.dac?
          true
        end
      end
    end
  end
end
