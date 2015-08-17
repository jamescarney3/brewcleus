Brewcleus.Views.SignIn = Backbone.View.extend({

  template: JST["shared/sign_in"],

  events: {
    "submit form":"submit"
  },

  submit: function(event){
    event.preventDefault();

    var view = this;
    var $form = $(event.currentTarget);
    var formData = $form.serializeJSON().user;

    Brewcleus.currentUser.signIn({
      username: formData.username,
      password: formData.password,
      error: function(){
        alert("Wrong username/password combination.")
      },
      success: function(){
        alert("Signed in " + Brewcleus.currentUser.get("username") + "!")
        // if(!view.signInCallback.bind(view));{
        //   Backbone.history.navigate("", {trigger: true});
        // };
      }
    });
  },

  render: function(){
    var html = this.template;
    this.$el.html(html);
    return this;
  },
});
