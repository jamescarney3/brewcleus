Brewcleus.Models.Recipe = Backbone.Model.extend({
  
  urlRoot: "api/recipes",

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
