module MyobAdvanced
  module Api
    module Model
      class PxObjectsCsTerms < Base
        def model_route
          'PX_Objects_CS_Terms'
        end

        def self.field_id
          'TermsID'
        end

        def self.field_name
          'Descr'
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
