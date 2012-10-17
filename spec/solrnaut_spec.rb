require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# mock sunspot searchable
module Sunspot
  module Rails
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def searchable(options = {}, &block)
        return "searchable method in AR model called"
      end  
    end
  end
end

ActiveRecord::Base.send :include, Sunspot::Rails

class SearchDelegator < ActiveRecord::Base

end

class SearchProxy
  include Solr::Naut

  searchable_on 'SearchDelegator' do |x|

  end  
end

class DummyProxy
  include Solr::Naut 
end

describe SearchProxy do

  it 'should have searchable method proxy' do
    SearchProxy.should respond_to( :searchable_on )
  end

  it 'should proxy search calls to actual activerecord model that includes sunspot' do
     
  end

end

describe DummyProxy do

  it 'should call the activerecord model that delegated search to DummyProxy' do
    DummyProxy.send( :searchable_on, 'SearchDelegator') do
      true
    end.should == "searchable method in AR model called"
  end

end
