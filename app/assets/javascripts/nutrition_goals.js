var NutritionGoals = window.NutritionGoals || {};

$(document).keypress(function(e) {
	if(e.which == 13) {
		EnterKeyPressedHandler();
		return false;
	}
	return true;
});



$(document).ready(function(){
	$("#desired_calories").change(function(){
		DesiredCaloriesChangedHandler();
	});


	$("#desired_calories").keypress(function(e) {
		if(e.which == 13) {
			DesiredCaloriesChangedHandler(); 
			return false;
		}
		return true;
	});


	$("#custom_percentage_entry_protein, #custom_percentage_entry_carbs, #custom_percentage_entry_total_fat").change(function(){
		UpdateTotalsByMacroPercentages();
	});


	$("#nutrition_goal_calories, #nutrition_goal_protein, #nutrition_goal_carbs, #nutrition_goal_total_fat").change(function () {
		UpdateTotalsByMacroNutrients();
	});


	$("#edit_nutrition_goal_preset_selection input[name='presets']:radio").click(function(){
		if(this.id == "custom_percentages_option"){
			UpdateTotalsByMacroPercentages();
			$("#custom_percentages_entry").slideDown('slow');
		} else {
			$("#custom_percentages_entry").slideUp('slow');
			CalculatePresetValues(this);
		}
	});
});


function EnterKeyPressedHandler(){
	if(IsCustomPercentageChecked()){
		UpdateTotalsByMacroPercentages();
	} else {
		UpdateTotalsByMacroNutrients();
	}
}


function IsCustomPercentageChecked(){
	if($("#custom_percentages_entry:checked")){
		return true;
	} else {
		return false;
	}           
}


function DesiredCaloriesChangedHandler(){
	if(IsCustomPercentageChecked() == true) {
		UpdateTotalsByMacroPercentages();
	} else {
		CalculatePresetValues($('input[name=presets]:checked'));
	}
}


function UpdateTotalsByMacroNutrients(){
	var userValues = NutritionGoals.GetUserCaloricValues();
	UpdateTotals(userValues);
}


function UpdateTotalsByMacroPercentages(){
	var calories = NutritionGoals.GetUserCaloriesValue();
	var proteinPercent = parseInt($("#custom_percentage_entry_protein").val());
	var carbsPercent = parseInt($("#custom_percentage_entry_carbs").val());
	var totalFatPercent = parseInt($("#custom_percentage_entry_total_fat").val());

	DisplayPercentSum(proteinPercent, carbsPercent, totalFatPercent);

	CalculateMacrosInGramsFromPercents(calories, proteinPercent, carbsPercent, totalFatPercent);
}


function DisplayPercentSum(proteinPercent, carbsPercent, totalFatPercent){
	var sum = proteinPercent + carbsPercent + totalFatPercent;
	var strToShow = "";
	var cssClass = 'alert-danger';

	if(sum > 100){
		strToShow = "You are at " + sum + "%! Remove " + (sum - 100) + " percentage points!";
	} 

	if(sum < 100) {
		strToShow = "You are at " + sum + "%! Add " + (100 - sum) + " percentage points!";
	}

	if(sum == 100){
		cssClass = 'alert-success';
		strToShow = sum + "% across all macronutrients.";
	}
	$("#custom_percentage_entry_sum").removeClass();
	$("#custom_percentage_entry_sum").addClass("alert " + cssClass);
	$("#custom_percentage_entry_sum").html(strToShow);
}


function CalculatePresetValues(radioBtn){
	var presetProteinPercent = $(radioBtn).data("protein-percent");
	var presetCarbsPercent = $(radioBtn).data("carbs-percent");
	var presetTotalFatPercent = $(radioBtn).data("total-fat-percent");
	var calories = NutritionGoals.GetUserCaloriesValue();

	CalculateMacrosInGramsFromPercents(calories, 
												  presetProteinPercent, 
												  presetCarbsPercent, 
												  presetTotalFatPercent);
}


function CalculateMacrosInGramsFromPercents(calories, proteinPercent, carbsPercent, totalFatPercent){
	var protein = Math.round(((proteinPercent / 100) * calories) / 4);
	var carbs = Math.round(((carbsPercent / 100) * calories) / 4);
	var total_fat = Math.round(((totalFatPercent / 100) * calories) / 9);

	SetUserValues(protein, carbs, total_fat);
	UpdateTotalsByMacroNutrients();
}


function SetUserValues(protein, carbs, total_fat){
	$("#nutrition_goal_protein").val(protein);
	$("#nutrition_goal_carbs").val(carbs);
	$("#nutrition_goal_total_fat").val(total_fat);
}


function UpdateTotals(userValues){
	var minCalories = NutritionGoals.MinimumCaloriesRequired(userValues);
	$("#protein_calories").html(" = " + userValues.protein + " kCal");
	$("#carbs_calories").html(" = " + userValues.carbs + " kCal");
	$("#total_fat_calories").html(" = " + userValues.total_fat + " kCal");
	$("#nutrition_goal_calories").val(minCalories);
};


NutritionGoals.MinimumCaloriesRequired = function(caloricValuesObj){
	var sum = caloricValuesObj.protein + caloricValuesObj.carbs + caloricValuesObj.total_fat;
	return sum;

	if(caloricValuesObj.calories < sum){
		return sum;
	} else {
		return caloricValuesObj.calories;
	}
};


NutritionGoals.GetUserCaloricValues = function () {
	var calories = NutritionGoals.GetUserCaloriesValue();
	var protein = NutritionGoals.CalcProteinCalories(NutritionGoals.GetUserProteinValue());
	var carbs = NutritionGoals.CalcCarbCalories(NutritionGoals.GetUserCarbValue());
	var fat = NutritionGoals.CalcFatCalories(NutritionGoals.GetUserFatValue());
	return { calories: calories, protein: protein, carbs: carbs, total_fat: fat };
};


function GetUserPercentageValues(){
	var protein = parseInt($("#custom_percentage_entry_protein").val());
	var carbs = parseInt($("#custom_percentage_entry_carbs").val());
	var fat = parseInt($("#custom_percentage_entry_total_fat").val());
	return { calories: 0, protein: protein, carbs: carbs, total_fat: fat };
};


NutritionGoals.GetUserProteinValue = function(){
	return $("#nutrition_goal_protein").val();  
};


NutritionGoals.GetUserCarbValue = function(){
	return $("#nutrition_goal_carbs").val();  
};


NutritionGoals.GetUserFatValue = function(){
	return $("#nutrition_goal_total_fat").val();  
};


NutritionGoals.GetUserCaloriesValue = function(){
	return $("#desired_calories").val();  
};


NutritionGoals.CalcProteinCalories = function (proteinAmount) {
	return (proteinAmount * 4);
};


NutritionGoals.CalcCarbCalories = function (carbAmount) {
	return (carbAmount * 4);
};


NutritionGoals.CalcFatCalories = function (fatAmount) {
	return (fatAmount * 9);
};
