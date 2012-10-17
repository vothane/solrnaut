require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

ActiveRecord::Base.send :include, Sunspot::Rails::Searchable

SearchDelegator < ActiveRecord::Base

end

SearchProxy
  search_on :SearchDelegator
end

describe Solrnaut do

  it 'have searchable method proxy'
    SearchProxy.should respond_to :searchable
  end

End
