Brewcleus.Routers.Router = Backbone.Router.extend({

  initialize: function(options){
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "": "landingPage",
    "session/new": "signIn",
    "users/form": "userForm",
    "recipes/new": "recipeForm",
    "recipes/:id/edit": "recipeForm"
  },

  landingPage: function(){
    var view = new Brewcleus.Views.LandingPage();
    this._swapView(view);
  },

  signIn: function(callback){
    var view = new Brewcleus.Views.SignIn({
      success: callback
    });
    this._swapView(view);
  },

  userForm: function(){
    var view = new Brewcleus.Views.UserForm();
    this._swapView(view);
  },

  recipeForm: function(id){
    if(this._requireSignedIn(function(){
      if(id){ this.recipeForm(id); };
      if(!id){ this.recipeForm(); };
    }.bind(this))){
      if(id){ var view = new Brewcleus.Views.RecipeForm({id: id}); };
      if(!id){ var view = new Brewcleus.Views.RecipeForm(); };
      this._swapView(view);
    };
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  },

  _requireSignedIn: function(callback){
    if(!Brewcleus.currentUser.isSignedIn()){
      this.signIn(callback);
      return false;
    };
    return true;
  }

});
