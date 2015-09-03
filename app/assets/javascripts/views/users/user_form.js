Brewcleus.Views.UserForm = Backbone.CompositeView.extend({

  template: JST["users/form"],

  events: {
    "submit form": "submit"
  },

// initialize and syncModel currently allow for situation where a user becomes
// signed in at any time while the view is active, possibly unnecessarily.
// Monitor this going forward

  initialize: function(){
    this.model = new Brewcleus.Models.User();
    this.syncModel();
    this.listenTo(Brewcleus.currentUser, "signIn signOut", this.syncModel);
    this.listenTo(this.model, "change", this.render);
  },

  syncModel: function(){
    this.model.set({id: Brewcleus.currentUser.id});
    if(!this.model.isNew()){
      this.model.fetch();
    }else{
      this.model.clear();
    };
  },

  submit: function(event){
    event.preventDefault();
    var formData = new FormData();

    var username = this.$("#input-user-username").val();
    formData.append("user[username]", username);

    var city = this.$("#input-user-city").val();
    formData.append("user[city]", city);

    var state = this.$("#input-user-state").val();
    formData.append("user[state]", state);

    var bio = this.$("#input-user-bio").val();
    formData.append("user[bio]", bio);

    var avatar = this.$("#input-user-avatar")[0].files[0];
    if(avatar){
      formData.append("user[avatar]", avatar);
    };

    var error = function(error){
      alert("Invalid/Incomplete Form Data: " + error);
    };

    if(this.model.isNew()){
      var password = this.$("#input-user-password").val();
      formData.append("user[password]", password);

      this.model.saveFormData(
        formData,
        { error: error,
          credentials: {username: username, password: password} }
      );
    }else{
      this.model.saveFormData(
        formData,
        { error: error }
      );
    }


  },

  render: function(){
    var html = this.template({user: this.model});
    this.$el.html(html);
    return this;
  }

});
