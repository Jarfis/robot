require_relative "spec_helper"

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#heal!" do
    it "should throw error when at 0 hp" do
      expect(@robot).to receive(:health).and_return(0)
      expect{@robot.heal!(2)}.to raise_error
#      @robot.heal!(2)
    end
  end

  describe "#attack!" do
    it "should throw error when target is invalid" do
      laser = Laser.new
      expect{@robot.attack!(laser)}.to raise_error(InvalidTargetError)
    end
  end
end
