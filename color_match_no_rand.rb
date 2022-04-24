#!/usr/bin/env ruby

require 'ruby2d'

#setting up window
set title: "Color Match"
set width: 800
set height: 600

#initializing rgb values for current and goal circles
r = 0.0
g = 0.0
b = 0.0

r1 = 0
g1 = 0
b1 = 0

#to make it easier, the button increases/decreases rgb values by 5
increment = 5

#initializing text
welcome_text = Text.new('Welcome to Color Match!', x: 300, y: 20, size: 20, color: "white", z: 1)
welcome_text = Text.new('Press the white button to begin or restart the game. Adjust the amounts of r, g, b using the colored arrows.', x: 50, y: 50, size: 15, color: "white", z: 1)

current_text_r = Text.new('R: 0', x: 510, y: 560, size: 20, color: "white", z: 1)
current_text_g = Text.new('G: 0', x: 580, y: 560, size: 20, color: "white", z: 1)
current_text_b = Text.new('B: 0', x: 650, y: 560, size: 20, color: "white", z: 1)

goal_text_rgb = Text.new('', x: 110, y: 560, size: 20, color: "white", z: 1)

reset_text = Text.new('Reset', x: 145, y: 455, size: 40, color: "black", z: 1)
show_text = Text.new('Show', x: 275, y: 105, size: 40, color: "white", z: 1)
check_text = Text.new('Check', x: 465, y: 105, size: 40, color: "white", z: 1)

congrats_text = Text.new('', x: 150, y: 260, size: 20, color: "black", z: 25)


#function to generate random colors between 0 and 255 in increments of 5
def reset_color(x)
  colors = []
  n = 0
  for n in 0..51
    colors.append(n * 5)
  end

  x = colors.shuffle[0]
  return x
end

#goal and current circles
goal = Circle.new(
  x: 200, y: 300,
  radius: 100,
  color: [r , g , b, 1]
)
current_circle = Circle.new(
  x: 600, y: 300,
  radius: 100,
  color: [r1, g1, b1, 1]
)

#all the action buttons
reset_button = Rectangle.new(
  x: 125, y: 450,
  width: 150, height: 75,
  color: [1, 1, 1, 1]
)

show_button = Rectangle.new(
  x: 250, y: 100,
  width: 150, height: 75,
  color: [0.1, 0.7, 0.6, 1]
)

check_button = Rectangle.new(
  x: 450, y: 100,
  width: 150, height: 75,
  color: [0.1, 0.7, 0.6, 1]
)

end_button = Rectangle.new(
  x: 300, y: 400,
  width: 150, height: 75,
  color: 'random',
  z: 25
)

end_button.remove

#increase/decrease buttons
reset_r = Circle.new(
  x: 540, y: 480,
  radius: 10,
  color: [1.0, 0.0, 0.0, 1]
)

r_dec = Triangle.new(
  x1: 600 - 60,  y1: (500 + 20 * Math.sqrt(3)),
  x2: 580 - 60, y2: 500,
  x3: 620 - 60,   y3: 500,
  color: [1.0, 0.0, 0.0, 1]
)

g_inc = Triangle.new(
  x1: 600,  y1: 450,
  x2: 580, y2: (450 + 20 * Math.sqrt(3)),
  x3: 620,   y3: (450 + 20 * Math.sqrt(3)),
  color: [0.0, 1.0, 0.0, 1]
)

g_dec = Triangle.new(
  x1: 600,  y1: (500 + 20 * Math.sqrt(3)),
  x2: 580, y2: 500,
  x3: 620,   y3: 500,
  color: [0.0, 1.0, 0.0, 1]
)

b_inc = Triangle.new(
  x1: 600 + 60,  y1: 450,
  x2: 580 + 60, y2: (450 + 20 * Math.sqrt(3)),
  x3: 620 + 60,   y3: (450 + 20 * Math.sqrt(3)),
  color: [0.0, 0.0, 1.0, 1]
)

b_dec = Triangle.new(
  x1: 600 + 60,  y1: (500 + 20 * Math.sqrt(3)),
  x2: 580 + 60, y2: 500,
  x3: 620 + 60,   y3: 500,
  color: [0.0, 0.0, 1.0, 1]
)



on :mouse_down do |event|
  #reset color
  if (reset_button.contains? event.x, event.y)
    color_list_1 = [r, g, b]
    
    color_list_1.map! {|number| reset_color(number)}
    color_list = color_list_1.map { |n| n / 255.0 } << 1
    $rgb_goal_color = color_list_1
    goal.color = color_list

    goal_text_rgb.text = " "

    puts color_list
    puts $rgb_goal_color
  end

  #check if goal and current are the same color, if so a new page appears
  if (check_button.contains? event.x, event.y)
    if r1 == $rgb_goal_color[0] && g1 == $rgb_goal_color[1] && b1 == $rgb_goal_color[2]
      $congrats = Rectangle.new(
        x: 50, y: 50,
        width: 700, height: 500,
        color: [1, 1, 1, 1],
        z: 20
      )
      congrats_text.text = "Congratulations! Click the button below to start a new game."
      puts "hi :("

    end_button.add
     

    end
  end
  
  #shows the goal rgb values
  if (show_button.contains? event.x, event.y)
    
    goal_text_rgb.text = "R: #{$rgb_goal_color[0]} G: #{$rgb_goal_color[1]} B: #{$rgb_goal_color[2]}"
  end

  #resets the game after the win page
  if (end_button.contains? event.x, event.y)
    $congrats.remove
    congrats_text.text = ""
    end_button.remove
    color_list_1 = [r, g, b]
    
    color_list_1.map! {|number| reset_color(number)}
    color_list = color_list_1.map { |n| n / 255.0 } << 1
    $rgb_goal_color = color_list_1
    goal.color = color_list

    goal_text_rgb.text = " "

    puts color_list
    puts $rgb_goal_color
  end

  #all of the increments
  if (reset_r.contains? event.x, event.y)
    unless r1 == 255
      r1 += increment
      current_circle.color = [r1/255.0, g1/255.0, b1/255.0, 1]
      puts "r1- = #{r1}"
      current_text_r.text = "R: #{r1}"
    end
  end

  if (r_dec.contains? event.x, event.y)
    unless r1 <= 0
      r1 -= increment
      current_circle.color = [r1/255.0, g1/255.0, b1/255.0, 1]
      puts "r1- = #{r1}"
      current_text_r.text = "R: #{r1}"
    end
  end
  if (g_inc.contains? event.x, event.y)
    unless g1 == 255
      g1 += increment
      current_circle.color = [r1/255.0, g1/255.0, b1/255.0, 1]
      puts "g1+ = #{g1}"
      current_text_g.text = "G: #{g1}"
    end
  end
  if (g_dec.contains? event.x, event.y)
    unless g1 <= 0
      g1 -= increment
      current_circle.color = [r1/255.0, g1/255.0, b1/255.0, 1]
      puts "g1- = #{g1}"
      current_text_g.text = "G: #{g1}"
    end
  end
  if (b_inc.contains? event.x, event.y)
    unless b1 == 255
      b1 += increment
      current_circle.color = [r1/255.0, g1/255.0, b1/255.0, 1]
      puts "b1+ = #{b1}"
      current_text_b.text = "B: #{b1}"
    end
  end
  if (b_dec.contains? event.x, event.y)
    unless b1 <= 0
      b1 -= increment
      current_circle.color = [r1/255.0, g1/255.0, b1/255.0, 1]
      puts "b1- = #{b1}"
      current_text_b.text = "B: #{b1}"
    end
  end
end


show