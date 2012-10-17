module Solr
   module Naut 
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def searchable_on(klass, &block)
          klass.constantize.send :searchable, &block 
        end
      end
   end
end