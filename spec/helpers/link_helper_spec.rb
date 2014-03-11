require 'spec_helper'

describe LinkHelper do
  let(:text) { "url text" }
  let(:item) { create(:exercise) }
  let(:item_path) { exercise_path(item) }

  describe "#link_to_add" do
    it "links to the specified url" do
      expect(helper.link_to_add(text, item)).to include(text)
      expect(helper.link_to_add(text, item)).to include(item_path)
      expect(helper.link_to_add(text, item)).to include("icon-plus icon-white")
      expect(helper.link_to_add(text, item)).to include("btn btn-success")
    end
  end

  describe "#link_to_destroy" do
    it "creates a button to remove an item" do
      expect(helper.link_to_destroy(text, item)).to include(text)
      expect(helper.link_to_destroy(text, item)).to include(item_path) 
      expect(helper.link_to_destroy(text, item)).to include("data-method=\"delete\"") 
      expect(helper.link_to_destroy(text, item)).to include("btn btn-danger") 
      expect(helper.link_to_destroy(text, item)).to include("data-confirm=\"Are you sure?\"") 
      expect(helper.link_to_destroy(text, item)).to include("icon-remove icon-white")
    end
  end
end
