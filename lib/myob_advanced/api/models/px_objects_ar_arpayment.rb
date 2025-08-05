module MyobAdvanced
  module Api
    module Model
      class PxObjectsArArpayment < Base
        def model_route
          'PX_Objects_AR_ARPayment'
        end

        def self.field_id
          'RefNbr'
        end

        def self.field_note_id(model_name = nil)
          'NoteID'
        end

        def self.dac?
          true
        end
      end
    end
  end
end
