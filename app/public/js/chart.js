$.getJSON(location.protocol + '//' + location.host + location.pathname + "chart_data.json" + window.location.search, function(data) {

  var maxNumExceptions = 100;
  var barWidth = 37;
  var barColor = "#F89406";
  var barHeight = 200;
  var xAxisPadding = 25;
  var height = barHeight + xAxisPadding;
  var width = (barWidth + 2) * data.length;

  var x = d3.scale.linear().domain([0, data.length]).range([0, width]);
  var y = d3.scale.linear().domain([0, d3.max(data, function(datum) { return datum.exceptions; }) + 20]).
    rangeRound([0, barHeight]);

  // add the canvas to the DOM
  var barDemo = d3.select("#chart").
    append("svg:svg").
    attr("width", width).
    attr("height", height);

  barDemo.selectAll("rect").
    data(data).
    enter().
    append("svg:rect").
    attr("x", function(datum, index) { return x(index); }).
    attr("y", function(datum) { return barHeight - y(datum.exceptions); }).
    attr("height", function(datum) { return y(datum.exceptions); }).
    attr("width", barWidth).
    attr("fill", barColor);
    
  barDemo.selectAll("text").
    data(data).
    enter().
    append("svg:text").
    attr("x", function(datum, index) { return x(index) + (barWidth / 1.4); }).
    attr("y", function(datum) { 
      var yPos = barHeight - y(datum.exceptions);
      if (yPos > barHeight - 20) {
        yPos = barHeight - 20;
      }
      return yPos; }).
    attr("dx", -barWidth/2).
    attr("dy", "1.2em").
    attr("text-anchor", "right").
    text(function(datum) {
      if (datum.exceptions < maxNumExceptions) {
        return datum.exceptions;
      }
      return (maxNumExceptions - 1) + "+" ;}).
    attr("fill", "white");

  barDemo.selectAll("text.yAxis").
    data(data).
    enter().append("svg:text").
    attr("x", function(datum, index) { return x(index) + (barWidth / 1.4); }).
    attr("y", barHeight).
    attr("dx", -barWidth/2).
    attr("text-anchor", "middle").
    attr("style", "font-size: 12; font-family: Helvetica, sans-serif").
    text(function(datum) { return datum.hour;}).
    attr("transform", "translate(0, 18)").
    attr("class", "yAxis");
    
});
