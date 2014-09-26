require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  test "create site" do
    t = Site.new
    t.name = "hello"
    t.date = 2014-07-24 
    t.description ="blabla"
    assert t.save
  end
end
