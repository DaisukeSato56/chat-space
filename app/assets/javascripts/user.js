$(document).on('turbolinks:load', function(){
  var search_list = $('#user-search-result');
  var users_list = $('#chat-group-users')

  function appendUser(user){
    var html = `<div class='chat-group-user clearfix'>
                  <p class='chat-group-user__name'>${ user.name }</p>
                  <a class='user-search-add chat-group-user__btn chat-group-user__btn--add' data-user-id='${ user.id }' data-user-name='${ user.name }'>追加</a>
                </div>`
    search_list.append(html);
  }

  function appendChatMember(userId, UserName) {
    var html = `
                <div class='chat-group-user clearfix js-chat-member' id='chat-group-user-8'>
                  <input name='group[user_ids][]' type='hidden' value='${ userName }'>
                  <p class='chat-group-user__name'>${ userName }</p>
                  <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>
                </div>
                `
    users_list.append(html);
  }

  $('#user-search-field').on('keyup', function(){
    var input = $('#user-search-field').val();
    var inputs = input.split(" ").filter(function(e) { return e; });
    var newInput = inputs.join();
    $.ajax({
      type: 'GET',
      url: '/users',
      data: { keyword: newInput },
      dataType: 'json'
    })
    .done(function(users){
      $('#user-search-result').empty();
      users.forEach(function(user){
        appendUser(user);
      });
      if (input.length == 0) {
        $('#user-search-result').empty();
      }
    })
    .fail(function() {
      alert('検索に失敗しました');
    })
  });

  $(document).on("click", '.chat-group-user__btn--add', function(){
    $(this).parent().remove();
    userId = $(this).attr('data-user-id')
    userName = $(this).attr('data-user-name')
    appendChatMember(userId, userName)
  });

  $(document).on("click", '.chat-group-user__btn--remove', function(){
    $(this).parent().remove();
  });
});
