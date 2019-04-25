require_relative "After.rb"
require_relative "Operation.rb"

module Post
    
    include After
    include Operation

    def post(&a_post)
      add_operation(proc { |name|
        redefine_method_with_afters name, [proc { |result|
          unless self.instance_exec result, &a_post
            raise "¡Post!"
          end
        }]
      })
    end
end