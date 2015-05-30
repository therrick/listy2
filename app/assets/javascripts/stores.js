$(document).ready( function () {
  // focus cursor in form field
  $("input#item_name").focus();

  // do a search on each key-press
  // add item form doubles search form filtering the item list
  $('input#item_name').keyup(function () {
    delay(function () {
      if (isXS()) {
        $('input#item_name').goTo();
      }
      filter_items('.item_list', $('input#item_name').val());
    }, 500);
    return false;
  });

  $('a.clear-row').click(function () {
    $(this).closest('tr').hide(500);
  });

  //
  // setup for item menu popup
  //
  $.fn.modal.defaults.spinner = $.fn.modalmanager.defaults.spinner =
      '<div class="loading-spinner" style="width: 200px; margin-left: -100px;">' +
      '<div class="progress progress-striped active">' +
      '<div class="progress-bar" style="width: 100%;"></div>' +
      '</div>' +
      '</div>';

  $.fn.modalmanager.defaults.resize = true;
});

function popup_item_menu(store_id, item_id) {
  // create the backdrop and wait for next modal to be triggered
  $('body').modalmanager('loading');

  var $modal = $('#menupopup-modal');

  setTimeout(function(){
    url = '/stores/' + store_id + '/items/' + item_id + '/menu_popup';
    $modal.load(url, '', function(){
      $modal.modal();
    });
  }, 1000);
}

function filter_items(selector, query) {
  query =   $.trim(query); //trim white space
  query = query.replace(/ /gi, '.*'); //allow space to match any characters
  if (query.length > 0) {
    $("#item_table_headings").hide();
  } else {
    $("#item_table_headings").show();
  }

  $(selector).each(function() {
    ($(this).find("td:nth-child(2)").text().search(new RegExp(query, "i")) < 0) ? $(this).css("display", "none") : $(this).css("display", "table-row");
  });
}

var delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();
