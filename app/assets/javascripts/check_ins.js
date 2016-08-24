$(document).ready(function(){

  $('#new_check_in').on('submit', function(ev){
    ev.preventDefault()
    $.post({
        url: $(ev.target).attr('action'),
        data: new FormData(ev.target),
        processData: false,
        contentType: false,
        success: function(data) {
          $('#CheckinModal').modal("hide")
          $('.sidebar_table_contents').prepend('<ul class="list-inline row"><li class="col-xs-4 text-left">' + moment(data.created_at).format('ll') + '</li><li class="col-xs-4 text-center">' + data.weight + '</li><li class="col-xs-4 text-center">' + data.new_bmi + '</li><ul>')
          document.getElementById('new_check_in').reset();
          $('#new_check_in input[type="submit"]').prop('disabled', false);
        }
    })
  })

})
