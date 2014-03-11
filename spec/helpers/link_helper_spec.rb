require 'spec_helper'

describe LinkHelper do
  describe "#link_to_add" do
    it "links to the specified url" do
      exercise = create(:exercise)
      expect(helper.link_to_add("test", exercise)).to include("test")
      expect(helper.link_to_add("test", exercise)).to include(exercise_path(exercise))
      expect(helper.link_to_add("test", exercise)).to include("icon-plus icon-white")
      expect(helper.link_to_add("test", exercise)).to include("btn btn-success")
    end
  end

  describe "#link_to_destroy" do
    it "creates a button to remove an item" do
      exercise = create(:exercise)
      text = "delete item"
      expect(helper.link_to_destroy(text, exercise)).to include(text)
      expect(helper.link_to_destroy(text, exercise)).to include(exercise_path(exercise)) 
      expect(helper.link_to_destroy(text, exercise)).to include("data-method=\"delete\"") 
      expect(helper.link_to_destroy(text, exercise)).to include("btn btn-danger") 
      expect(helper.link_to_destroy(text, exercise)).to include("data-confirm=\"Are you sure?\"") 
      expect(helper.link_to_destroy(text, exercise)).to include("icon-remove icon-white")
    end
  end
end
