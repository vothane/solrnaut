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

      def search(options = {}, &block)
        return "found it in Solr using sunspot"
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
    SearchProxy.should respond_to :searchable_on 
  end

  it 'should have search method proxy' do
    SearchProxy.should respond_to :search 
  end

  it 'should have delegate search to ActiveRecord model with sunspot that delegated search to proxy' do
    SearchProxy.send( :search, {:query => "find this"} ) do
      true
    end.should == "found it in Solr using sunspot"
  end

end

describe DummyProxy do

  it 'should call the activerecord model that delegated search to DummyProxy' do
    DummyProxy.send( :searchable_on, 'SearchDelegator' ) do
      true
    end.should == "searchable method in AR model called"
  end

end
