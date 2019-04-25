require_relative "Before.rb"
require_relative "Operation.rb"

module Pre
    
    include Before
    include Operation

    def pre(&a_pre)
        add_operation(proc {|name|
          redefine_method_with_befores name, [proc {
            unless self.instance_exec &a_pre
              raise "¡Pre!"
            end
          }]
        })
    end
end