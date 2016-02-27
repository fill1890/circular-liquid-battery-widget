###
Animation mode options:
1: Double-wave flowing animation
2: Flat fill with pulsing intensity
3: Flat fill with no animation (Least CPU intensive)
Will default to 3 if invalid or no value.
###
animationMode: 1

# Distance from top and left of screen in pixels
topPosition: 300
leftPosition: 200

command: "pmset -g batt | grep \"%\""

refreshFrequency: 20000

render: () ->
  if @animationMode is 1
    background = """
      <svg viewBox="0 0 316 168" width="316" height="168" class="wavebg">
        <path d="M0,5c0,0,17.6,5.1,39.6,5.1c19.3,0,29.9-2.5,39.5-5C88.8,2.7,98.8,0,118.7,0s29.9,2.6,39.5,5.1
          c9.6,2.5,19,5,39.5,5c20.6,0,29.9-2.3,39.5-5c9.6-2.7,17.6-5.1,39.4-5.1c20,0,39.4,5.1,39.4,5.1V168H0.1L0,5z"/>
      </svg>
      <svg viewBox="0 0 316 168" width="316" height="168" class="wavefg">
        <path d="M0,5c0,0,17.6,5.1,39.6,5.1c19.3,0,29.9-2.5,39.5-5C88.8,2.7,98.8,0,118.7,0s29.9,2.6,39.5,5.1
          c9.6,2.5,19,5,39.5,5c20.6,0,29.9-2.3,39.5-5c9.6-2.7,17.6-5.1,39.4-5.1c20,0,39.4,5.1,39.4,5.1V168H0.1L0,5z"/>
        </svg>
    """
  else if @animationMode is 2
    background = '<div class="flatfill pulse"></div>'
  else
    background = '<div class="flatfill"></div>'

  """
  <div id="batt" style="top: #{@topPosition}px; left: #{@leftPosition}px">
    <canvas id="blur"></canvas>
    <div id="circle-battery" class="wave">
      #{background}
      <p class="percent"></p>
      <p class="capt"></p>
      <svg class="icon" viewbox="0 0 1200 1200"></svg>
    </div>
  </div>
  """

afterRender: (domEl) ->
  uebersicht.makeBgSlice(el) for el in $(domEl).find('#blur')

update: (output, domEl) ->
  outputParts = output.split(';')
  outputParts[0] = outputParts[0].trim().split(' ')[1]
  outputParts = (x.trim() for x in outputParts)
  index0 = parseInt(outputParts[0])

  if 0 <= index0 <= 100
    percent = index0
    source = outputParts[1]
  else
    percent = parseInt(outputParts[1])
    source = outputParts[0]

  domEl = $(domEl)

  if source is 'discharging'
    power = "Battery"
    icon = @batteryImage
  else if source is 'charged'
    power = 'Charged'
    icon = @chargeImage
  else
    power = 'Charging'
    icon = @chargeImage

  bgPosition = 150 - percent / 100 * 160 - 10 + 4
  fgcolor = if percent <= 20 then 'f03844' else '2ce64c'
  bgcolor = if percent <= 20 then 'dd2b36' else '2fb93f'
  pulseName = if percent <= 20 then 'pulse-animation-red' else 'pulse-animation'

  if @animationMode is 1
    $(domEl.find('.wavefg')[0]).css({top: "#{bgPosition}px", 'fill': "##{fgcolor}"})
    $(domEl.find('.wavebg')[0]).css({top: "#{bgPosition - 4}px", 'fill': "##{bgcolor}"})
  else if @animationMode is 2
    $(domEl.find('.flatfill')[0]).css({top: "#{bgPosition + 12}px", 'animation-name': "#{pulseName}"})
  else
    $(domEl.find('.flatfill')[0]).css({top: "#{bgPosition + 12}px", 'background-color': "##{fgcolor}"})

  $(domEl.find('.percent')[0]).text("#{percent}%")
  $(domEl.find('.capt')[0]).text(power)
  domEl.find('.icon')[0].innerHTML = icon

style: """
  @font-face
    font-family 'Dosis'
    font-style normal
    font-weight 200
    src local('Dosis ExtraLight'), local('Dosis-ExtraLight'), url(http://fonts.gstatic.com/s/dosis/v4/zuuDDmIlQfJeEM3Uf6kkpnYhjbSpvc47ee6xR_80Hnw.woff) format('woff')

  base = 'circular-liquid-battery.widget/'
  bg-blur = 10px

  #batt
    position relative
    width 158px
    height 158px
    border-radius 50%
    overflow hidden
    box-shadow 0 0 5px 3px rgba(0, 0, 0, 0.3)

  #blur
    position absolute
    left -(bg-blur) + 4px
    top -(bg-blur) + 4px
    width 150px + 2*(bg-blur)
    height 150px + 2*(bg-blur)
    border-radius 50%
    filter blur(10px)
    z-index -1

  #circle-battery
    position absolute
    left 0
    right 0
    width 150px
    height 150px
    border 4px solid white
    border-radius 50%
    font-family 'Dosis', sans-serif
    color white
    font-weight 200
    font-size 46px
    text-align center
    z-index 2
    overflow hidden
    transform: translateZ(0)

  #circle-battery .icon
    position absolute
    top 115px
    left 60px
    width 30px
    height 30px
    fill white

  #circle-battery .capt
    margin-top -50px
    font-size 10px

  .wavefg
  .wavebg
    position absolute
    left 0
    z-index -5

  .wavefg
    animation: wave-animation 1s infinite linear

  .wavebg
    animation: wave-animation 2s infinite linear

  .flatfill
    position absolute
    left 0
    z-index -5
    width 154px
    height 154px

  .pulse
    animation: pulse-animation 4s infinite linear

  @keyframes wave-animation
    from
      transform: translateX(-158px)
    to
      transform: translateX(0px)

  @keyframes pulse-animation
    0%
      background-color #2ce64c
    50%
      background-color #2fb93f
    100%
      background-color #2ce64c

  @keyframes pulse-animation-red
    0%
      background-color #f03844
    50%
      background-color #dd2b36
    100%
      background-color #f03844

"""

chargeImage: '<polygon points="808,0 234,699 566,699 393,1200 969,501 636,501 "/>'
batteryImage: '''
<path d="M1013,250c57.1,0,109.1,52.2,109.1,104.5v109.7h67.5c5.2,0,10.4,5.2,10.4,10.4v250.7
	c0,5.2-5.2,10.4-10.4,10.4h-67.5v109.7c0,52.2-51.9,104.5-109.1,104.5H103.9C51.9,950,0,897.8,0,845.5v-491
	C0,302.2,51.9,250,103.9,250H1013z M103.9,302.2c-26,0-51.9,26.1-51.9,52.2v491c0,26.1,26,52.2,51.9,52.2H1013
	c31.2,0,57.1-26.1,57.1-52.2l0-156.7c0-5.2,5.2-10.4,10.4-10.4h62.3V521.6h-62.3c-5.2,0-10.4-5.2-10.4-10.4l0-156.7
	c0-26.1-26-52.2-57.1-52.2H103.9z"/>
<path d="M103.9,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
<path d="M213,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
<path d="M316.9,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
<path d="M426,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
<path d="M529.2,811.6c0,47,62.3,47,62.3,0V383.2c0-47-62.3-47-62.3,0V811.6z"/>
<path d="M638.3,811.6c0,47,62.3,47,62.3,0V383.2c0-47-62.3-47-62.3,0V811.6z"/>
<path d="M742.9,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
<path d="M851.9,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
<path d="M955.8,814.2c0,47,62.3,47,62.3,0V385.8c0-47-62.3-47-62.3,0V814.2z"/>
'''
