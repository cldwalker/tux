require File.dirname(__FILE__) + '/test_helper'

describe Tux::Commands do
  def ripl
    @ripl ||= Object.new.extend(Tux::Commands)
  end

  describe "#app" do
    it "is an instance of the sinatra app" do
      ripl.app.class.should == Tux.app_class
    end

    it "can call a helper method" do
      ripl.app.moo('man').should == 'moo-man'
    end

    it "can call render methods" do
      ripl.app.respond_to?(:erb, true).should == true
      ripl.app.respond_to?(:render, true).should == true
    end
  end

  describe "#settings" do
    it "retrieves default setting" do
      ripl.settings.assoc('absolute_redirects')[1].should == true
    end

    it "retrieves app-specific setting" do
      ripl.settings.assoc('root')[1].should == 'dir'
    end

    it "retrieves failing setting" do
      ripl.settings.assoc('ka')[1].should =~ /boom/
    end
  end

  describe "#routes" do
    it "retrieves string path" do
      ripl.routes.assoc('GET')[1].should == '/'
    end

    it "retrieves path with params" do
      ripl.routes.assoc('POST')[1].should == "/:id/:format"
    end
  end
end
