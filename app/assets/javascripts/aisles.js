$(document).ready( function () {
  if (isIOS()) {
    $('.handle').hide();
  } else {
    $('.up').hide();
  }

  $('#aisles-list').sortable(
      {
        axis: 'y',
        dropOnEmpty:false,
        handle: '.handle',
        cursor: 'crosshair',
        items: 'li',
        opacity: 0.4,
        scroll: true,
        update: function(){
          $.ajax({
            type: 'post',
            data: $('#aisles-list').sortable('serialize'),
            dataType: 'script',
            complete: function(request){
              $('#aisles-list').effect('highlight');
            },
            url: 'aisles/sort'})
        }
      })
});
