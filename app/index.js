var config = require('./config/app');
window.App = Ember.Application.create(config);

require('./templates.js'); // created by emberTemplate task
require('./routes/router');
