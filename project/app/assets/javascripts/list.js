document.addEventListener("turbolinks:load", function() {
  $(".list").on("click", function(){
    $(this).parents(".list-header").children(".list-item").toggleClass("item-hide");
  });
});