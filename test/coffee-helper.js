require('coffee-script');
require('coffee-script/register');
require('fs').readdirSync(__dirname + '/').forEach(function(file) {
  if (file.match(/.+\.coffee/g) !== null) {
    var name = file.replace('.coffee', '');
    exports[name] = require('./' + file);
  }
});