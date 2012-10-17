require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# mock sunspot searchable
module Sunspot
  module Rails
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def searchable(options = {}, &block)
        return true
      end  
    end
  end
end

ActiveRecord::Base.send :include, Sunspot::Rails

class SearchDelegator < ActiveRecord::Base

end

class SearchProxy
  include Solr::Naut

  searchable_on :SearchDelegator do |x|

  end  
end

describe Solrnaut do

  it 'should have searchable method proxy' do
    SearchProxy.should respond_to( :search_on )
  end

  it 'should proxy search calls to actual activerecord model that includes sunspot' do
    #SearchProxy.search do |s|

    #end  
  end

end
