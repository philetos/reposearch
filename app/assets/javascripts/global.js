$(document).ready( function() {
  
  function validateForm(){
    var query = document.forms["search-form"]["query_text"].value;
    if ( query == null || query == "" ){
      return false;
    }
  };
  
  $( "#search-form" ).submit(function(event) {
    var result = validateForm();

    if ( result === false) {
      $('#alertModal').modal();
      event.preventDefault();
    }
  });
  

  // Searching Gif
  $(document).ajaxSend(function(event, request, settings) {
    $('#searching-indicator').addClass("searching"); 
    $('#searching-indicator').show();
  });

  $(document).ajaxComplete(function(event, request, settings) {
    $('#searching-indicator').removeClass("searching"); 
    $('#searching-indicator').hide();
    window.scrollTo(0,0);
  });
});