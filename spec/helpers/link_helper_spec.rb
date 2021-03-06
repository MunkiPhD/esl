require 'rails_helper'

describe LinkHelper do
  let(:text) { "url text" }
  let(:item) { create(:workout) }
  let(:item_path) { workout_path(item) }
  let(:item_edit_path) { edit_workout_path(item) }


  describe "#link_to_add" do
    it "links to the specified url" do
      result = helper.link_to_add(text, item)
      expect(result).to include(text)
      expect(result).to include(item_path)
      expect(result).to include("btn btn-success")
    end

    it "does not conflict with other html options" do
      result = link_to_add(text, item, class: "test")
      expect(result).to include("test btn btn-success")
    end
  end

  describe "#link_to_destroy" do
    it "creates a button to remove an item" do
      result = helper.link_to_destroy(text, item)
      expect(result).to include(text)
      expect(result).to include(item_path) 
      expect(result).to include("type=\"submit\"") 
      expect(result).to include("btn btn-danger") 
      expect(result).to include("icon-remove")
    end

    it "does not conflict with other html options" do
      result = link_to_destroy(text, item, class: "test")
      expect(result).to include("test btn btn-danger")
    end

    it "has additional parameters passed in" do
      result = link_to_destroy(text, item, data: {confirm: "Are you sure?"}, method: "delete")
      expect(result).to include("value=\"delete\"")
      expect(result).to include("data-confirm=\"Are you sure?\"")
    end
  end

	describe '#link_to_ajax_destroy' do
    it "creates a link to remove an item" do
      result = helper.link_to_ajax_destroy(text, item)
      expect(result).to include(text)
      expect(result).to include(item_path) 
      expect(result).to include("href=") 
      expect(result).to include("btn btn-danger") 
      expect(result).to include("icon-remove")
    end

    it "does not conflict with other html options" do
      result = link_to_ajax_destroy(text, item, class: "test")
      expect(result).to include("test btn btn-danger")
    end

    it "has additional parameters passed in" do
      result = link_to_ajax_destroy(text, item, data: {confirm: "Are you sure?"}, method: "delete")
      expect(result).to include("data-method=\"DELETE\"")
      expect(result).to include("data-confirm=\"Are you sure?\"")
    end
	end

  describe "#link_to_edit" do
    it "creates a link to the edit page" do
      result = link_to_edit(text, item_edit_path)
      expect(result).to include(text)
      expect(result).to include(item_edit_path)
      expect(result).to include("btn btn-primary")
      expect(result).to include("icon-pencil")
    end

    it "does not conflict with other html options" do
      result = link_to_edit(text, item_edit_path, class: "test")
      expect(result).to include("test btn btn-primary")
    end
  end


  describe "#button_to_submit" do
    it "creates a link to submit a form" do
      result = button_to_submit(text)
      expect(result).to include(text)
      expect(result).to include("type=\"submit\"")
      expect(result).to include("btn btn-primary")
      expect(result).to include("icon-ok")
      expect(result).to include("name=\"commit\"")
    end

    it "has a default of 'Save Changes'" do
      result = button_to_submit
      expect(result).to include("Save Changes")
    end

    it "does not conflict with other options" do
      result = button_to_submit(text, class: "test")
      expect(result).to include("test btn btn-primary")
    end
  end
end
