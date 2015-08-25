Brewcleus.Routers.Router = Backbone.Router.extend({

  initialize: function(options){
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "": "landingPage",
    "session/new": "signIn",
    "users/form": "userForm",
    "users/:id": "userShow",
    "recipes/new": "recipeForm",
    "recipes/:id/edit": "recipeForm",
    "recipes/:recipe_id/batches/new": "batchForm",
    "recipes/:recipe_id/batches/:batch_id/edit": "batchForm",
    "recipes/:recipe_id/batches/:batch_id": "batchShow",
    "recipes/:id": "recipeShow"
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

  userShow: function(id){
    var user = new Brewcleus.Models.User({id: id});
    var view = new Brewcleus.Views.UserShow({ model: user });
    this._swapView(view);
  },

  recipeForm: function(id){
    if(this._requireSignedIn(function(){
      id ? this.recipeForm(id) : this.recipeForm();
    }.bind(this))){
      var recipeIngredients = new Brewcleus.Collections.RecipeIngredients();
      if(id){
        this._enforceRecipeAuthor(id, function(){
          var recipe = new Brewcleus.Models.Recipe({id: id});
          var view = new Brewcleus.Views.RecipeForm({
            model: recipe,
            collection: recipeIngredients
          });
          this._swapView(view);
        }.bind(this));
      }else{
        var recipe = new Brewcleus.Models.Recipe();
        var view = new Brewcleus.Views.RecipeForm({
          model: recipe,
          collection: recipeIngredients
        });
        this._swapView(view);
      };
    };
  },

  recipeShow: function(id){
    var recipe = new Brewcleus.Models.Recipe({id: id});
    var view = new Brewcleus.Views.RecipeShow({ model: recipe });
    this._swapView(view);
  },

  batchForm: function(recipe_id, batch_id){
    var batch = new Brewcleus.Models.Batch({ id: batch_id, recipe_id: recipe_id });
    var view = new Brewcleus.Views.BatchForm({ model: batch});
    this._swapView(view);
  },

  batchShow: function(recipe_id, batch_id){
    var batch = new Brewcleus.Models.Batch({id: batch_id, recipe_id: recipe_id});
    var view = new Brewcleus.Views.BatchShow({ model: batch});
    this._swapView(view);
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
  },

  _enforceRecipeAuthor: function(id, callback){
    var recipe = new Brewcleus.Models.Recipe({id: id});
    recipe.verifyAuthorId({
      success: callback
    });
  }

});
