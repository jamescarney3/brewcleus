Brewcleus.Models.User = Backbone.Model.extend({
  urlRoot: "/api/users",

});

Brewcleus.Models.CurrentUser = Brewcleus.Models.User.extend({

  url: "api/session",

  signIn: function(options){
    var model = this;
    var credentials = {
      "user[username]": options.username,
      "user[password]": options.password
    };

    $.ajax({
      url: this.url,
      type: "POST",
      data: credentials,
      dataType: "json",
      success: function(data){
        model.set(data);
        options.success && options.success();
      },
      error: function(){
        options.error && options.error();
      }
    });
  },

  signOut: function(options){
    var model = this;

    $.ajax({
      url: this.url,
      type: "DELETE",
      dataType: "json",
      success: function(data){
        model.clear();
        options.success && options.success();
      }
    });
  }

});
