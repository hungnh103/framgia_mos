$(document).on('click', '.submit-confess', function(e){
  if($('#confession_content').val().trim() == ""){
    alert('You must write something!');
    e.preventDefault();
  }
});
