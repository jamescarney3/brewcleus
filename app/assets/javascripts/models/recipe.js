Brewcleus.Models.Recipe = Backbone.Model.extend({

  urlRoot: "api/recipes",

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
        options.success(resp.id);
      },
      error: function(resp){
        options.error(resp.responseText);
      }
    });
  },

// turns out this isn't especially necessary if I'm also validating for this in
// the recipe ActiveRecord model, but it could be useful for streamlining UX in
// case of a non-malicious but lost user typing stuff into the address bar

  verifyAuthorId: function(options){
    var model = this;
    var url = this.urlRoot + "/" + this.id + "/author_id";

    $.ajax({
      url: url,
      type: "GET",
      success: function(resp){
        if(resp.author_id == Brewcleus.currentUser.id){
          options.success();
        }else{
          alert("Signed in user is not author of requested recipe.");
          Backbone.history.navigate("", {trigger: true});
        };
      },
      error: function(resp){
        alert("Author ID could not be verified for requested recipe.");
        Backbone.history.navigate("", {trigger: true});
      }
    });
  }

});
