Brewcleus.Views.Header = Backbone.View.extend({

  // template: JST['shared/header'],

  template: JST["shared/header"],

  events: {
    "click #sign-out-link" : "signOut"
  },

  initialize: function(options){
    this.listenTo(Brewcleus.currentUser, "signIn signOut change", this.render);
    this.render();
  },

  signOut: function(event){
    event.preventDefault();

    Brewcleus.currentUser.signOut({
      success: function(){
        Backbone.history.navigate("", { trigger: true });
      }
    });
  },

  render: function(){
    var html = this.template;
    this.$el.html(html);
    return this;
  },

});
