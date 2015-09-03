Brewcleus.Models.User = Backbone.Model.extend({
  urlRoot: "/api/users",

  saveFormData: function(formData, options){
    var method = this.isNew() ? "POST" : "PUT";
    var model = this;

    $.ajax({
      url: _.result(model, "url"),
      type: method,
      data: formData,
      processData: false,
      contentType: false,
      success: function(resp){
        if(options.credentials){
          Brewcleus.currentUser.signIn(options.credentials);
        };
        Backbone.history.navigate("", {trigger: true});
      },
      error: function(resp){
        options.error && options.error(resp.responseText);
      }
    });

  }

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
        options.success();
      },
      error: function(){
        options.error();
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
