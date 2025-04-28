module MyobAdvanced
  module Api
    module Model
      class PxObjectsGlAccount < Base
        def model_route
          'PX_Objects_GL_Account'
        end

        # def self.field_id
        #   'AcctCD'
        # end

        # def self.field_name
        #   'AcctName'
        # end

        def self.dac?
          true
        end
      end
    end
  end
end
