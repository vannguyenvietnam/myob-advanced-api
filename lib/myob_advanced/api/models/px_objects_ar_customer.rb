module MyobAdvanced
  module Api
    module Model
      class PxObjectsArCustomer < Base
        def model_route
          'PX_Objects_AR_Customer'
        end

        def self.field_id
          'AcctCD'
        end

        def self.field_name
          'AcctName'
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
