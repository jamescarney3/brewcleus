Brewcleus.Views.SignIn = Backbone.CompositeView.extend({

  template: JST["shared/sign_in"],

  events: {
    "submit form":"submit"
  },

  initialize: function(options){
    this.successCallback = options.success || function(){
      Backbone.history.navigate("", {trigger: true});
    };
    this.errorCallback = options.error || function(){
      alert("Username/Password combination invalid.");
    };
  },

  submit: function(event){
    event.preventDefault();

    var view = this;
    var $form = $(event.currentTarget);
    var formData = $form.serializeJSON().user;

    Brewcleus.currentUser.signIn({
      username: formData.username,
      password: formData.password,
      success: view.successCallback,
      error: view.errorCallback
    });
  },

  render: function(){
    var html = this.template;
    this.$el.html(html);
    return this;
  },
});
