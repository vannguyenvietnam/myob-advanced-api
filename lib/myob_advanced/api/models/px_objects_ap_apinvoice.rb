module MyobAdvanced
  module Api
    module Model
      class PxObjectsApApinvoice < Base
        def model_route
          'PX_Objects_AP_APInvoice'
        end

        def self.field_id
          'RefNbr'
        end

        def self.field_note_id
          'NoteID'
        end

        def self.dac?
          true
        end
      end
    end
  end
end
