Template['balance_chart'].rendered = ->
  console.log @$('#balance_chart').get(0)
  ctx = @$('#balance_chart').get(0).getContext('2d')
  console.log ctx

  balances = []
  for balance, index in @data.balances()
    if index % 20 is 0
      balances.push balance

  data = 
    labels: _.map(balances, (balance) ->
      return moment(balance.date).format('L')
    )
    datasets: [
      {
        label: "Balance"
        fillColor: "rgba(220,220,220,0.2)"
        strokeColor: "rgba(220,220,220,1)"
        pointColor: "rgba(220,220,220,1)"
        pointStrokeColor: "#fff"
        pointHighlightFill: "#fff"
        pointHighlightStroke: "rgba(220,220,220,1)"
        data: _.map(balances, (balance) ->
          return balance.value()
        )
      }
    ]
  myLineChart = new Chart(ctx).Line(data, null)
