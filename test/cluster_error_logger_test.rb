require 'test_helper'

class ClusterErrorLoggerTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, ClusterErrorLogger
  end
end
