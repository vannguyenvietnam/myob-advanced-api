module MyobAdvanced
  module Api
    module Model
      class PxObjectsArAradjust < Base
        def model_route
          'PX_Objects_AR_ARAdjust'
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
