module Psych::Visitors
  ToRuby.class_eval do
    def resolve_class(klassname)
      begin
        class_loader.load klassname
      rescue Psych::DisallowedClass => e
        require_dependency klassname.underscore
        klassname.constantize
      end
    end
  end
end
