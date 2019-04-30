require_relative "Before.rb"
require_relative "Operation.rb"

module Pre
    
    include Before
    include Operation

    attr_accessor :pre_expected_to_define

    def pre(&a_pre)

        if pre_expected_to_define
          raise "Ya hay un pre"
        end
        self.pre_expected_to_define= true

        run_on_method_added(true) {|name|
          self.pre_expected_to_define= false
          redefine_method_with_before name, proc {
            unless self.instance_exec &a_pre
              raise "¡Pre!"
            end
          }
        }
    end
end