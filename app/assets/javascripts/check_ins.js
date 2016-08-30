$(document).ready(function(){

  $('#new_check_in').on('submit', function(ev){
    ev.preventDefault()
    $.post({
        url: $(ev.target).attr('action'),
        data: new FormData(ev.target),
        processData: false,
        contentType: false,
        success: function(data) {
          var = context{
            created_at: moment(data.created_at).format('ll'),
            weight: data.weight,
            new_bmi: data.new_bmi
          }
          $('#CheckinModal').modal("hide")
          $('.sidebar_table_contents').prepend(context)
          document.getElementById('new_check_in').reset();
          $('#new_check_in input[type="submit"]').prop('disabled', false);
        },
        error: function(error){
        console.log(error)
        }
    })
  })

})
