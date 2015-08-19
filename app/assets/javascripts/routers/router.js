Brewcleus.Routers.Router = Backbone.Router.extend({

  initialize: function(options){
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "": "landingPage",
    "session/new": "signIn",
    "users/form": "userForm"
  },

  landingPage: function(){
    var view = new Brewcleus.Views.LandingPage();
    this._swapView(view);
  },

  signIn: function(){
    var view = new Brewcleus.Views.SignIn();
    this._swapView(view);
  },

  userForm: function(){
    var view = new Brewcleus.Views.UserForm();
    this._swapView(view);
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }

});
