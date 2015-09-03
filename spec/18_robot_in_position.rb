require_relative "spec_helper"
describe Robot do
  before :each do
    robot = Robot.new
    robot.move_up
  end

  it "find a robot at position [0,1]" do
    expect(Robot.in_position(0,1)).to be_truthy
  end
end
