# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Workouts ||= {}
Workouts = window.Workouts

Workouts.remove_fields = (link) ->
  $(link).prev("input[type=hidden]").val("1")
  $(link).closest(".fields").hide()

Workouts.add_fields = (link, association, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id))
  

Workouts.add_exercise = (parent) ->
  try
    template = $("#workouts_templates_add_exercise").html()
    time = new Date().getTime()
    rendered = Mustache.render(template, { number: time })
    $(parent).prev(".workouts_workout_exercise").after(rendered)
    $("a[data-action='workouts.add_set']").on("click", ->
      Workouts.add_set(this)
    )
  catch error
    alert error
