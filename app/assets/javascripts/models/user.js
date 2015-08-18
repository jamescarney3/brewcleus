Brewcleus.Models.User = Backbone.Model.extend({
  urlRoot: "/api/users",

});

Brewcleus.Models.CurrentUser = Brewcleus.Models.User.extend({

  url: "api/session",

  initialize: function(options){
    this.listenTo(this, "change", this.fireSessionEvent);
  },

  isSignedIn: function(){
    return !this.isNew();
  },

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
        alert("Signed in " + Brewcleus.currentUser.get("username") + "!");
        if(options.success){ options.success(); };
        Backbone.history.navigate("", {trigger: true});
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
        alert("Signed out!");
        if(options && options.success){ options.success(); };
        Backbone.history.navigate("", {trigger: true});
      }
    });
  },

  fireSessionEvent: function(){
    if(this.isSignedIn()){
      this.trigger("signIn");
    }else{
      this.trigger("signOut");
    };
  }

});
