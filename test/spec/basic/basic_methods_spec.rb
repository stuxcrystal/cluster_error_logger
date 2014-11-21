require "rails_helper"
include ClusterErrorLogger

describe ClusterErrorLogger do
  describe "#log_debug" do
    before(:each) { File.delete File.expand_path("#{Rails.root}/../cluster_log/error.log") }
    it "writes to error.log" do
      fail
      log = File.open(File.expand_path("#{Rails.root}/../cluster_log/error.log"))
      expect(log).not_to eq ""
    end
  end
end