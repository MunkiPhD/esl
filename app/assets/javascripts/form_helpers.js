function SetTodaysDateOnSelects($container){
		var today = new Date();
		var day = today.getDate();
		var month = today.getMonth() + 1;
		var year = today.getFullYear();

		$container.find("select.select-day").val(day);
		$container.find('select.select-month option[value="' + month + '"]').prop('selected', true);
		$container.find('select.select-year option[value="' + year + '"]').prop('selected', true);

		return false;
}
