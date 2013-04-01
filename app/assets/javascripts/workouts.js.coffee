# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Workouts ||= {}

window.Workouts.add_exercise = ->
  template = $("workouts.exercise_template").html()
  alert 'test'

$ ->
  $("a[data-action='workouts.add_set']").click ->
    alert "test"
