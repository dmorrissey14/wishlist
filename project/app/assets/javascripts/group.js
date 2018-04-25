document.addEventListener("turbolinks:load", function() {
  $(".collapse-target").on("click", function(){
    $(this).parents(".group-header").children(".group-details").toggleClass("item-hide");
  });
});
