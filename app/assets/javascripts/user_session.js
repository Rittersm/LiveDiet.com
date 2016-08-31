$(document).ready(function(){

  $('.login').on('submit', function(ev){
    ev.preventDefault()
    $(this).prev().remove()
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
        console.log(ev.target)
        console.log($('input[type="submit"]', ev.target))
        $(ev.target).before(HandlebarsTemplates['error'](error))
        setTimeout(function(){
          $('input[type="submit"]:first', ev.target).prop('disabled', false)
        }, 0)
      }
    })
  })

})
