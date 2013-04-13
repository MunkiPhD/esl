# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Workouts ||= {}
Workouts = window.Workouts

Workouts.remove_fields = (link) ->
  $(link).prev("input[type=hidden]").val("1")
  #$(link).closest(".fields").hide()
  parent = $(link).parents(".workouts_workout_exercise") # get the parent workout_exercise container so we can iterate and renumber the sets
  $(link).parent().find(".set-field").removeClass("set-field") # remove the way in which we find the sets (since theyre simply hidden not removed)
  $(link).closest(".fields").hide() # then hide the row for the set
  Workouts.renumberSetFields(parent) # and renumber the sets

Workouts.add_fields = (link, association, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id))
  parent = $(link).parents(".workouts_workout_exercise")
  Workouts.renumberSetFields(parent)
  

Workouts.renumberSetFields = (container) ->
  setCounter = 1
  $(container).find(".set-field").each (i) ->
    $(this).val(setCounter)
    $(this).prev(".set-number").html(setCounter)
    setCounter++
  true
