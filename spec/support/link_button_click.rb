module LinkButtonClickHelper
	def click_remove_link
		click_link_by_name("Remove")
	end

	def click_delete_link
		click_link_by_name("Delete")
	end

	def click_edit_link
		click_link_by_name("Edit")
	end

	def click_link_by_name(name)
		find(:css, "a[name='#{name}']").click
	end
end
