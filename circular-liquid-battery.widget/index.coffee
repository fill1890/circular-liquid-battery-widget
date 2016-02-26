command: "pmset -g batt | grep \"%\" | awk 'BEGINN { FS = \";\" };{ print $3,$2 }' | sed -e 's/-I/I/' -e 's/-0//' -e 's/;//' -e 's/;//'"

refreshFrequency: 20000

render: () ->
  '<div id="batt"></div>'

update: (output) ->
  outputParts = output.split(' ')
  percent = parseInt(outputParts[1].split('%')[0])
  source = outputParts[0]

  if source is 'discharging'
    power = "Battery"
    icon = 'bat'
  else if source is 'charged'
    power = 'Charged'
    icon = 'charge'
  else
    power = 'Charging'
    icon = 'charge'

  wave = switch
    when percent <= 20 then '20'
    when 20 < percent <= 35 then '35'
    when 35 < percent <= 50 then '50'
    when 50 < percent <= 90 then '80'
    when 90 < percent < 100 then '90'
    when percent == 100 then '100'

  $('#batt').html("""
    <div id="circle-battery" class="wave#{wave}">
      <p>#{percent}%</p>
      <p class="capt">#{power}</p>
      <img src="circular-liquid-battery.widget/#{icon}.png" width="30" />
      </div>
    <div id="counter" class="waveb#{wave}"></div>
  """)

style: """
  #batt
    top 300px
    left 200px
    position relative

  #counter{
  	z-index:1;
      width:154px;
      height:154px;
      border-radius:50%;
      position: absolute;
      left: 100px;
      right: 0;
      top: 100px;
      bottom: 0;

  }
  #circle-battery {
  	z-index:2;
      width:150px;
      height:150px;
      border: 4px solid white;
      border-radius:50%;
      position: absolute;
      left: 100px;
      right: 0;
      top: 100px;
      bottom: 0;
  	font-family: 'Dosis', sans-serif;
  	color:white;
  	font-weight: 200;
  	font-size: 46px;
  	text-align: center;
      -webkit-box-shadow: 0px 0px 5px 3px rgba(0, 0, 0, 0.3);
      -moz-box-shadow: 0px 0px 5px 3px rgba(0, 0, 0, 0.3);
      box-shadow: 0px 0px 5px 3px rgba(0, 0, 0, 0.3);
  }
  #circle-battery img{
  	position:absolute;
  	top:115px;
  	left:60px;
  }
  #circle-battery .capt{
  	margin-top:-50px;
  	font-size:10px;
  }
  .wave20 {
      background-image: url("circular-liquid-battery.widget/r1.png");
  	-webkit-animation: wave-animation 1s infinite linear;
  	-moz-animation: wave-animation 1s infinite linear;
  	-o-animation: wave-animation 1s infinite linear;
      animation: wave-animation 1s infinite linear;
      background-size: 200px 35px;
      background-repeat: repeat-x;
      opacity: 1;
  }
  .waveb20 {
      background-image: url("circular-liquid-battery.widget/r2.png");
  	-webkit-animation: wave-animation 2s infinite linear;
  	-moz-animation: wave-animation 2s infinite linear;
  	-o-animation: wave-animation 2s infinite linear;
      animation: wave-animation 2s infinite linear;
      background-size: 200px 39px;
      background-repeat: repeat-x;
      opacity: 1;
  }
  .wave35 {
      background-image: url("circular-liquid-battery.widget/g1.png");
  	-webkit-animation: wave-animation 1s infinite linear;
  	-moz-animation: wave-animation 1s infinite linear;
  	-o-animation: wave-animation 1s infinite linear;
      animation: wave-animation 1s infinite linear;
      background-size: 200px 65px;
      background-repeat: repeat-x;
      opacity: 1;
  }
  .waveb35 {
      background-image: url("circular-liquid-battery.widget/g2.png");
  	-webkit-animation: wave-animation 2s infinite linear;
  	-moz-animation: wave-animation 2s infinite linear;
  	-o-animation: wave-animation 2s infinite linear;
      animation: wave-animation 2s infinite linear;
      background-size: 200px 69px;
      background-repeat: repeat-x;
      opacity: 1;
  }
  .wave50 {
      background-image: url("circular-liquid-battery.widget/g1.png");
  	-webkit-animation: wave-animation 1s infinite linear;
  	-moz-animation: wave-animation 1s infinite linear;
  	-o-animation: wave-animation 1s infinite linear;
      animation: wave-animation 1s infinite linear;
      background-size: 200px 105px;
      background-repeat: repeat-x;
      opacity: 1;
  }
  .waveb50 {
      background-image: url("circular-liquid-battery.widget/g2.png");
  	-webkit-animation: wave-animation 2s infinite linear;
  	-moz-animation: wave-animation 2s infinite linear;
  	-o-animation: wave-animation 2s infinite linear;
      animation: wave-animation 2s infinite linear;
      background-size: 200px 109px;
      background-repeat: repeat-x;
      opacity: 1;
  }
  .wave80 {
      background-image: url("circular-liquid-battery.widget/g1.png");
  	-webkit-animation: wave-animation 1s infinite linear;
  	-moz-animation: wave-animation 1s infinite linear;
  	-o-animation: wave-animation 1s infinite linear;
      animation: wave-animation 1s infinite linear;
      background-size: 200px 165px;
      background-repeat: repeat-x;
      opacity: 1;
  }
  .waveb80 {
      background-image: url("circular-liquid-battery.widget/g2.png");
  	-webkit-animation: wave-animation 2s infinite linear;
  	-moz-animation: wave-animation 2s infinite linear;
  	-o-animation: wave-animation 2s infinite linear;
      animation: wave-animation 2s infinite linear;
      background-size: 200px 169px;
      background-repeat: repeat-x;
      opacity: 1;
  }
  .wave90 {
      background-image: url("circular-liquid-battery.widget/g1.png");
  	-webkit-animation: wave-animation 1s infinite linear;
  	-moz-animation: wave-animation 1s infinite linear;
  	-o-animation: wave-animation 1s infinite linear;
      animation: wave-animation 1s infinite linear;
      background-size: 200px 195px;
      background-repeat: repeat-x;
      opacity: 1;
  }
  .waveb90 {
      background-image: url("circular-liquid-battery.widget/g2.png");
  	-webkit-animation: wave-animation 2s infinite linear;
  	-moz-animation: wave-animation 2s infinite linear;
  	-o-animation: wave-animation 2s infinite linear;
      animation: wave-animation 2s infinite linear;
      background-size: 200px 199px;
      background-repeat: repeat-x;
      opacity: 1;
  }
  .wave100 {
      background-image: url("circular-liquid-battery.widget/g1.png");
  	-webkit-animation: wave-animation 1s infinite linear;
  	-moz-animation: wave-animation 1s infinite linear;
  	-o-animation: wave-animation 1s infinite linear;
      animation: wave-animation 1s infinite linear;
      background-size: 200px 235px;
      background-repeat: repeat-x;
      opacity: 1;
  }
  .waveb100 {
      background-image: url("circular-liquid-battery.widget/g2.png");
  	-webkit-animation: wave-animation 2s infinite linear;
  	-moz-animation: wave-animation 2s infinite linear;
  	-o-animation: wave-animation 2s infinite linear;
      animation: wave-animation 2s infinite linear;
      background-size: 200px 235px;
      background-repeat: repeat-x;
      opacity: 1;
  }
  @-webkit-keyframes wave-animation {
      0% {
          background-position: 0 bottom;
      }
      100% {
          background-position: 200px bottom;
      }
  }

"""
