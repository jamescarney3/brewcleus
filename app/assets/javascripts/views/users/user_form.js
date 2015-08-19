Brewcleus.Views.UserForm = Backbone.View.extend({

  template: JST["users/form"],

// initialize and syncModel currently allow for situation where a user becomes
// signed in at any time while the view is active, possibly unnecessarily.
// Monitor this going forward

  initialize: function(){
    this.model = new Brewcleus.Models.User();
    this.syncModel();
    this.listenTo(Brewcleus.currentUser, "all", this.syncModel);
    this.listenTo(this.model, "change", this.render);
  },

  syncModel: function(){
    this.model.set({id: Brewcleus.currentUser.id});
    if(this.model.id){
      this.model.fetch();
    }else{
      this.model.clear();
    };
  },

  render: function(){
    var html = this.template({user: this.model});
    this.$el.html(html);
    return this;
  }

});
