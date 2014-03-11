require 'spec_helper'

describe LinkHelper do
  describe "#add_link" do
    it "links to the specified url" do
      exercise = create(:exercise)
      expect(helper.add_link("test", exercise)).to include("test")
      expect(helper.add_link("test", exercise)).to include(exercise_path(exercise))
      expect(helper.add_link("test", exercise)).to include("icon-plus icon-white")
    end
  end
end
