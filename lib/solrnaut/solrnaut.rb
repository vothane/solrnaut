module Solr
   module Naut 
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        @klass

        def searchable_on(klass, &block)
          @klass = klass
          @klass.constantize.send :searchable, &block 
        end

        def search(options = {}, &block)
          @klass.constantize.send :search, options, &block 
        end
      end
   end
end