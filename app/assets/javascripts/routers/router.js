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
      id ? this.recipeForm(id) : this.recipeForm();
    }.bind(this))){
      if(id){
        this._enforceRecipeAuthor(id, function(){
          var view = new Brewcleus.Views.RecipeForm({id: id});
          this._swapView(view);
        }.bind(this));
        var view = new Brewcleus.Views.RecipeForm({id: id});
      }else{
        var view = new Brewcleus.Views.RecipeForm();
        this._swapView(view);
      };
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
  },

  _requireSignedOut: function(callback){
    if(Brewcleus.currentUser.isSignedIn()){
      this.signIn(callback);
      return false;
    };
    return true;
  }

  _enforceRecipeAuthor: function(id, callback){
    var recipe = new Brewcleus.Models.Recipe({id: id});
    recipe.verifyAuthorId({
      success: callback
    });
  }

});
