document.addEventListener("turbolinks:load", function() {
  $(".group-name").on("click", function(){
    $(this).parents(".group-header").children(".group-details").toggleClass("item-hide");
  });
});
