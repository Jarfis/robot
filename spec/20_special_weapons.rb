require_relative "spec_helper"
describe SpecialWeapon do
  before :each do
    @r1=Robot.new
    @r1.move_up
    @r2=Robot.new
    @r2.move_left
    @r2.move_up
    @r3=Robot.new
    @r3.move_up
    @r3.move_up
    @r0=Robot.new
    @sw = SpecialWeapon.new
  end

  describe "explode" do
    it "should hit enemies 1 tile away" do
      expect(@r1).to receive(:pierce).with(30)
      expect(@r2).to receive(:pierce).with(30)
      @sw.explode(@r0)
    end

    it "should bypass shields" do
      @sw.explode(@r0)
      expect(@r1.health).to eq(70)
      expect(@r1.shields).to eq(50)
    end

    it "should not hit enemies 2 tiles away" do
      expect(@r3).to_not receive(:pierce).with(30)
      @sw.explode(@r0)
    end
  end
end
