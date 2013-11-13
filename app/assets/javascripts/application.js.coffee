$(document).ready ->
  $('#vehicle_history_plate_number').autocomplete
    source: "/ajax/users"
    select: (event,ui) ->
      $("#post_vehicle_id").val(ui.item.id)