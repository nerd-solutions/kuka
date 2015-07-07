Package.describe({
  name: 'kuka',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'Package for Kuka',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
    // api.use('mongo@1.0.4');
    // api.imply('mongo');

    api.use([
    'ui',
    'twbs:bootstrap@3.3.5',
    'mrt:moment',
    'coffeescript',
    'jquery',
    'less',
    'fortawesome:fontawesome@4.3.0',
    'mquandalle:jade@0.4.3',
    'rcy:nouislider'
    ],'client');
  api.versionsFrom('1.1.0.2');
  
// Shared 
  api.use([
    'aldeed:simple-schema',
    'aldeed:collection2',
    'templating',
    'minimongo',
    'mongo',
    'underscore'
    ]);
  api.addFiles([
    'lib/helpers/helpers.coffee'
    ],['client','server']);
  api.addFiles([
    'lib/vote-slider/voteSlider.jade',
    'lib/vote-slider/voteSlider.coffee',
    'lib/alerts/alerts.coffee',
    'lib/alerts/alerts.jade',
    'lib/alerts/notificationItem.jade'
    ],'client');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('kuka');
  api.addFiles('kuka-tests.js');
});
