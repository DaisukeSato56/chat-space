$(function(){
  function buildHTML(message) {
    var image = message.image.url ? `<img src="${ message.image.url }" class: "lower-message__image">` : ``;
    var content = message.content ? `${ message.content }` : ``;
    var html = `<div class="message">
                  <div class="upper-message clearfix">
                    <div class="upper-message__name">
                      ${ message.name }
                    <div class="upper-message__date"
                      ${ message.created_at }
                    </div>
                  </div>
                  <div class="lower-message">
                    <p class="lower-message__content">
                      ${ content }
                    </p>
                    ${ image }
                  </div>
                </div>`
    return html;
  }
  $('.new-message').on('submit', function(e) {
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentData: false
    })
    .done(function(date){
      var html = buildHTML(data);
      $('.messages').append(html)
      $('.new-message__text').val('')
      $('.new-message__image2').val('')
      $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'fast');
    })
    .fail(function(){
      alert('error');
    })
  });
});
