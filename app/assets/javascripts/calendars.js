function toggleMealTimeForm(o){
  if ($(o).parent().siblings('.meal-time-display').css('display') == 'inline-block') {
    $(o).parent().siblings('.meal-time-display').css('display', 'none');
    $(o).parent().siblings('.meal-time-form').css('display', 'inline-block');
  } else {
    $(o).parent().siblings('.meal-time-display').css('display', 'inline-block');
    $(o).parent().siblings('.meal-time-form').css('display', 'none');
  }
}


if ($('body').attr('id') == 'calendars-index') {
}
