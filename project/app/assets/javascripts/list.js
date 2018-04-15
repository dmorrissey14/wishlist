document.addEventListener("turbolinks:load", function() {
  $(".collapse-target").on("click", function(){
    $(this).parents(".list-header").children(".list-item").toggleClass("item-hide");
  });
  $(".collapse-target").on("click", function(){
    $(this).find(".dropdown").toggleClass("fa-caret-right fa-caret-down");
  });
});