require 'spec_helper'

describe LinkHelper do
  let(:text) { "url text" }
  let(:item) { create(:exercise) }
  let(:item_path) { exercise_path(item) }

  describe "#link_to_add" do
    it "links to the specified url" do
      result = helper.link_to_add(text, item)
      expect(result).to include(text)
      expect(result).to include(item_path)
      expect(result).to include("icon-plus icon-white")
      expect(result).to include("btn btn-success")
    end
  end

  describe "#link_to_destroy" do
    it "creates a button to remove an item" do
      result = helper.link_to_destroy(text, item)
      expect(result).to include(text)
      expect(result).to include(item_path) 
      expect(result).to include("data-method=\"delete\"") 
      expect(result).to include("btn btn-danger") 
      expect(result).to include("data-confirm=\"Are you sure?\"") 
      expect(result).to include("icon-remove icon-white")
    end
  end
end
