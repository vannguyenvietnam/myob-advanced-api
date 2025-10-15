module MyobAdvanced
  module Api
    module Model
      class PxObjectsSoSoorder < Base
        def model_route
          'PX_Objects_SO_SOOrder'
        end

        def self.field_id
          'NoteID'
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
