var apiRoot = {
  prod: 'http://api.leveragecampaignfinance.org',
  dev: '/test-data'
};

function setApiRoot (root, suffix) {
  return function getEndpoint (path) {
    return root + path + (suffix || '');
  }
}

function getParams () {
  if (!window.location.search) return {};
  var params = {};
  var qstring = window.location.search.slice(1);
  qstring.split('&').forEach(function (param) {
    [key, val] = param.split('=')
    params[key] = val;
  });
  return params;
}

$(document).ready(function(){
  var params = getParams();
  var getEndpoint;
  if (params.test) {
    getEndpoint = setApiRoot(apiRoot.dev, '.json');
  } else {
    getEndpoint = setApiRoot(apiRoot.prod);
  }
  var endpoint = getEndpoint('/campaigns');
  $.get(endpoint, function(campaigns){
    var template = $('#campaign-entry-template').html();
    campaigns.forEach(function(campaign){
      var element = $.parseHTML(Mustache.render(template, campaign));
      $('#campaign-list tbody').append(element);
    });
    if (params.test) $('a').each(function(){
      var href = $(this).attr('href');
      if (!href) return;
      if (href.indexOf('test=1') < 0) {
        if (href.indexOf('?') < 0) {
          $(this).attr('href', href + '?test=1');
        } else {
          $(this).attr('href', href + '&test=1');
        }
      }
    });
  });
});
