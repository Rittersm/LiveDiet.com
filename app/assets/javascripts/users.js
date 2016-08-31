$(document).ready(function(){

  $('.new_user').on('submit', function(ev){
    ev.preventDefault()
    $.post({
      url: $(ev.target).attr('action'),
      data: new FormData(ev.target),
      processData: false,
      contentType: false,
      success: function(data){
        console.log(data)
        window.location.reload()
      },
      error: function(error){
        console.log(error)
        $(ev.target).before(HandlebarsTemplates['error'](error))
        $('.new_user input[type="submit"]').prop('disabled', false)
      }
    })
  })

})
