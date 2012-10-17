module Solr
   module Naut 
      def self.included(base)
         base.extend ClassMethods
      end

      module ClassMethods
         def searchable_on(klass)
            
            class << self
               
            end

         end
      end
   end
end