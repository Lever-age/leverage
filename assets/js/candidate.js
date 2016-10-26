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
  if (!window.location.search) return;
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
  if (!params.id) return;
  var getEndpoint;
  if (params.test) {
    getEndpoint = setApiRoot(apiRoot.dev, '.json');
  } else {
    getEndpoint = setApiRoot(apiRoot.prod);
  }
  var endpoint = getEndpoint('/candidates/' + params.id);
  $.get(endpoint, function(candidate){
    $('#candidate-name').text(candidate.candidate_name);
    var template = $('#campaign-panel-template').html();
    candidate.campaigns.forEach(function (campaign) {
      var element = $.parseHTML(Mustache.render(template, campaign));
      $('#campaigns-panel').append(element);

      var data = [
        {
          "key" : "Donations",
          "bar": true,
          "values" : campaign.campaign_summary.map(function(summary){
            return [parseInt(summary.summary_level, 10), summary.summary_value]
          })
        }
      ]

      nv.addGraph(function() {
        var chart = nv.models.linePlusBarChart()
          .margin({top: 30, right: 60, bottom: 50, left: 70})
          .x(function(d,i) { return i })
          .y(function(d,i) { return d[1] })
          .options({focusEnable: false})
          .showLegend(false)
          .color(d3.scale.category10().range())
          ;

          chart.xAxis
          .axisLabel('Donation Amount')
          .showMaxMin(false)
          .tickFormat(function(d) {
            return data[0].values[d] && data[0].values[d][0];
          });

          chart.y1Axis
          .tickFormat(d3.format(',f'));

          chart.bars.forceY([0]);

          d3.select('#campaign-' + campaign.campaign_id + ' svg')
          .datum(data)
          .transition().duration(500)
          .call(chart);

          nv.utils.windowResize(chart.update);

          return chart;
        });

    });
  });
});
