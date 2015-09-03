require_relative "spec_helper"

describe Robot do
  before :each do
    @robot = Robot.new
  end
  
  it "should start with 50 shields" do
    expect(@robot.shields).to eq(50)
  end

  describe "shields" do
    it "should drain before health" do
      @robot.wound(25)
      expect(@robot.shields).to eq(25)
      expect(@robot.health).to eq(100)
    end

    it "should damage health when shields are gone" do
      @robot.wound(60)
      expect(@robot.shields).to eq(0)
      expect(@robot.health).to eq(90)
    end
  end
end
