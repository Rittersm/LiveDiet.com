$(document).ready(function(){

  $('#new_plan').on('submit', function(ev){
    ev.preventDefault()
    $.post({
        url: $(ev.target).attr('action'),
        data: new FormData(ev.target),
        processData: false,
        contentType: false,
        success: function(data) {
          console.log(data)
          $('#PlanModal').modal("hide")
          if (window.location.pathname === '/plans'){
            $('#'+ data.category.title.replace(" ", "").toLowerCase() +'').prepend(HandlebarsTemplates['plan'](data))
            $('#'+ data.category.title.replace(" ", "").toLowerCase() +'tab').tab('show')
          }
          document.getElementById('new_plan').reset();
          $('#new_plan input[type="submit"]').prop('disabled', false);
        }
        error: function(error){
        console.log(error)
        }
    })
  })

})
