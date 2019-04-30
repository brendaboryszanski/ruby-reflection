require_relative "After.rb"
require_relative "Operation.rb"

module Post
    
    include After
    include Operation

    attr_accessor :post_expected_to_define

    def post(&a_post)

      if post_expected_to_define
        raise "Ya hay un post"
      end
      self.post_expected_to_define= true

      run_on_method_added(true) { |name|
        self.post_expected_to_define= false
        redefine_method_with_after name, proc { |result|
          unless self.instance_exec result, &a_post
            raise "¡Post!"
          end
        }
      }
    end
end