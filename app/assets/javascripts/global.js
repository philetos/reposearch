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
  

  // Loading Gif
  $(document).ajaxSend(function(event, request, settings) {
    $('#loading-indicator').addClass("loading"); 
    $('#loading-indicator').show();
  });

  $(document).ajaxComplete(function(event, request, settings) {
    $('#loading-indicator').removeClass("loading"); 
    $('#loading-indicator').hide();
    window.scrollTo(0,0);
  });
});