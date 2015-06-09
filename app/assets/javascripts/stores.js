$(document).ready( function () {
  // focus cursor in form field
  $("input#item_name").focus();

  // do a search on each key-press
  // add item form doubles search form filtering the item list
  $('input#item_name').keyup(function (e) {
    if (e.keyCode == 38 || e.keyCode == 40) return; // handled by up/down nav
    delay(function () {
      if (isXS()) {
        $('input#item_name').goTo();
      }
      filter_items('.item_list', $('input#item_name').val());
    }, 500);
    return false;
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

  // up/down navigation of item list
  $("body#stores-show").on("keydown", function(e){
    var selectedIndex = $("tr.item_list.found.selected").index();
    if (selectedIndex < 0) {
      selectedIndex = 0;
    }
    var maxIndex = $("tr.item_list").size();
    var newIndex = null;
    if(e.keyCode === 13) {
      $('form#new_item').submit();
    }
    else if(e.keyCode === 38) {
      // up
      console.log("up.  selectedIndex=" + selectedIndex)
      if (selectedIndex <= 1) {
        newIndex = maxIndex;
      } else {
        newIndex = selectedIndex - 1;
      }
      while (!$($("tr.item_list")[newIndex - 1]).hasClass("found")) {
        if (newIndex == selectedIndex) {
          break;
        }
        newIndex -= 1;
        if (newIndex <= 1) {
          newIndex = maxIndex;
        }
      }
    }
    else if(e.keyCode === 40) {
        // down
        console.log("down.  selectedIndex=" + selectedIndex)
        if (selectedIndex >= maxIndex) {
          newIndex = 1;
        } else {
          newIndex = selectedIndex + 1;
        }
        while (!$($("tr.item_list")[newIndex - 1]).hasClass("found")) {
          if (newIndex == selectedIndex) {
            break;
          }
          newIndex += 1;
          if (newIndex > maxIndex) {
            newIndex = 0;
          }
        }
    }
    if (newIndex !== null) {
      console.log("newIndex=" + newIndex)
      $("tr.item_list.selected").removeClass("selected")
      $($("tr.item_list")[newIndex - 1]).addClass("selected")
      selectedValue = $($("tr.item_list.selected")[0].children[1]).html().replace(/<div.*\/div>/,'').trim();
      $('input#item_name')[0].value = selectedValue;
      e.preventDefault();
    }
    // left = 37
    // right = 39
   });
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
    if ($(this).find("td:nth-child(2)").text().search(new RegExp(query, "i")) < 0) {
      $(this).removeClass("found")
    } else {
      $(this).addClass("found");
    }
  });
}

var delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();
