require_relative "spec_helper"

describe Robot do
  it "should be contained in the @@the_robots variable" do
    robot = Robot.new
    expect(Robot.the_robots.include?(robot)).to be_truthy
  end
end
