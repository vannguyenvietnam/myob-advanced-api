module MyobAdvanced
  module Api
    module Model
      class PxObjectsCrContact < Base
        def model_route
          'PX_Objects_CR_Contact'
        end

        def self.field_id
          'ContactID'
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
