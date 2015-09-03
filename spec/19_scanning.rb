require_relative "spec_helper"
describe Robot do
  before :each do
    @r1 = Robot.new
    @r1.move_up
    @r1.move_up
    @r2 = Robot.new
    @r2.move_left
    @r3 = Robot.new
  end

  describe "#scan" do

    it "should not detect a robot 2 tiles away" do
      puts @r1.inspect
      expect(@r1.scan).to be_empty
    end

    it "should detect a robot 1 tile away" do
      expect(@r3.scan.include?(@r2)).to be_truthy
    end
  end
end
