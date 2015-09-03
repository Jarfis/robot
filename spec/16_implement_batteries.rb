require_relative "spec_helper"

describe Battery do
  before :each do
    @battery = Battery.new
  end

  it "should be called Battery and weight 25" do
    expect(@battery.name).to eq("Battery")
    expect(@battery.weight).to eq(25)
  end

  context "with robot" do
    before :each do
      @robot = Robot.new
    end

    describe "#recharge" do
      it "should recharge the robots shield" do
        @robot.wound(25)
        expect(@robot).to receive(:heal_shields).with(50)
        @battery.recharge(@robot)
      end
    end
  end
end
