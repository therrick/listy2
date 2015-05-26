$(document).ready( function () {
  // focus cursor in form field
  $("input#item_name").focus();

  // do an search on each key-press
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
});

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
