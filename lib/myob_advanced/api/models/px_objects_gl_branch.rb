module MyobAdvanced
  module Api
    module Model
      class PxObjectsGlBranch < Base
        def model_route
          'PX_Objects_GL_Branch'
        end

        def self.field_note_id(model_name = nil)
          'BranchID'
        end

        def self.dac?
          true
        end
      end
    end
  end
end
