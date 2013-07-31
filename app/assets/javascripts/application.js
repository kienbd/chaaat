// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require ckeditor/init
//
var $subcriber =  function(id) {
  var faye = new Faye.Client('http://localhost:9292/faye');
  faye.subscribe('/messages/new/' + id, function (data) {
    eval(data);
  });
};

var call_on_room_add_member = function(user_id,room_id) {
    $.ajax({
      dataType: 'script',
      type: 'get',
      url: '/rooms/add_member' ,
      data: {room_id:  room_id,user_id: user_id},
      success : function() {
      }
    });
}

var call_on_room_remove_member = function(user_id,room_id) {
    $.ajax({
      dataType: 'script',
      type: 'get',
      url: '/rooms/remove_member' ,
      data: {room_id:  room_id,user_id: user_id},
      success : function() {
      }
    });
}

var call_on_room_toggle_admin = function(user_id,room_id) {
    $.ajax({
      dataType: 'script',
      type: 'get',
      url: '/rooms/toggle_admin' ,
      data: {room_id:  room_id,user_id: user_id},
      success : function() {
      }
    });
}

var create_p2p = function(user1_id,user2_id) {
  $.ajax({
    dataType: 'html',
    type: 'post',
    url: '/rooms/create_p2p',
    data: {user1_id: user1_id,user2_id: user2_id},
    success : function() {
    }
  })
}

CKEDITOR.config.toolbar = [
   ['Styles','Font','FontSize'],
   ['Bold','Italic','Underline','StrikeThrough','-','TextColor'],
   ['NumberedList','BulletedList','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
   ['Smiley']
] ;
CKEDITOR.config.removePlugins = 'elementspath';



