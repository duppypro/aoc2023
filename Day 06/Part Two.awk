# --- Day 6: Wait For It ---
# The ferry quickly brings you across Island Island. After asking around, you discover that there is indeed normally a large pile of sand somewhere near here, but you don't see anything besides lots of water and the small island where the ferry has docked.

# As you try to figure out what to do next, you notice a poster on a wall near the ferry dock. "Boat races! Open to the public! Grand prize is an all-expenses-paid trip to Desert Island!" That must be where the sand comes from! Best of all, the boat races are starting in just a few minutes.

# You manage to sign up as a competitor in the boat races just in time. The organizer explains that it's not really a traditional race - instead, you will get a fixed amount of time during which your boat has to travel as far as it can, and you win if your boat goes the farthest.

# As part of signing up, you get a sheet of paper (your puzzle input) that lists the time allowed for each race and also the best distance ever recorded in that race. To guarantee you win the grand prize, you need to make sure you go farther in each race than the current record holder.

# The organizer brings you over to the area where the boat races are held. The boats are much smaller than you expected - they're actually toy boats, each with a big button on top. Holding down the button charges the boat, and releasing the button allows the boat to move. Boats move faster if their button was held longer, but time spent holding the button counts against the total race time. You can only hold the button at the start of the race, and boats don't move until the button is released.

# For example:

# Time:      7  15   30
# Distance:  9  40  200
# This document describes three races:

# The first race lasts 7 milliseconds. The record distance in this race is 9 millimeters.
# The second race lasts 15 milliseconds. The record distance in this race is 40 millimeters.
# The third race lasts 30 milliseconds. The record distance in this race is 200 millimeters.
# Your toy boat has a starting speed of zero millimeters per millisecond. For each whole millisecond you spend at the beginning of the race holding down the button, the boat's speed increases by one millimeter per millisecond.

# So, because the first race lasts 7 milliseconds, you only have a few options:

# Don't hold the button at all (that is, hold it for 0 milliseconds) at the start of the race. The boat won't move; it will have traveled 0 millimeters by the end of the race.
# Hold the button for 1 millisecond at the start of the race. Then, the boat will travel at a speed of 1 millimeter per millisecond for 6 milliseconds, reaching a total distance traveled of 6 millimeters.
# Hold the button for 2 milliseconds, giving the boat a speed of 2 millimeters per millisecond. It will then get 5 milliseconds to move, reaching a total distance of 10 millimeters.
# Hold the button for 3 milliseconds. After its remaining 4 milliseconds of travel time, the boat will have gone 12 millimeters.
# Hold the button for 4 milliseconds. After its remaining 3 milliseconds of travel time, the boat will have gone 12 millimeters.
# Hold the button for 5 milliseconds, causing the boat to travel a total of 10 millimeters.
# Hold the button for 6 milliseconds, causing the boat to travel a total of 6 millimeters.
# Hold the button for 7 milliseconds. That's the entire duration of the race. You never let go of the button. The boat can't move until you let go of the button. Please make sure you let go of the button so the boat gets to move. 0 millimeters.
# Since the current record for this race is 9 millimeters, there are actually 4 different ways you could win: you could hold the button for 2, 3, 4, or 5 milliseconds at the start of the race.

# In the second race, you could hold the button for at least 4 milliseconds and at most 11 milliseconds and beat the record, a total of 8 different ways to win.

# In the third race, you could hold the button for at least 11 milliseconds and no more than 19 milliseconds and still beat the record, a total of 9 ways you could win.

# To see how much margin of error you have, determine the number of ways you can beat the record in each race; in this example, if you multiply these values together, you get 288 (4 * 8 * 9).

# Determine the number of ways you could beat the record in each race. What do you get if you multiply these numbers together?

# Your puzzle answer was 4811940.

# Duration: 41 96 88 94
# Record: 214 1789 1127 1055
# roots of race 2 are 6.138593 and 34.861407 => 28 wins  (28.722813)
# roots of race 3 are 25.306389 and 70.693611 => 45 wins  (45.387223)
# roots of race 4 are 15.557075 and 72.442925 => 57 wins  (56.885851)
# roots of race 5 are 13.029424 and 80.970576 => 67 wins  (67.941151)

# Answer is 4811940

# The first half of this puzzle is complete! It provides one gold star: *

# --- Part Two ---
# As the race is about to start, you realize the piece of paper with race times and record distances you got earlier actually just has very bad kerning. There's really only one race - ignore the spaces between the numbers on each line.

# So, the example from before:

# Time:      7  15   30
# Distance:  9  40  200
# ...now instead means this:

# Time:      71530
# Distance:  940200
# Now, you have to figure out how many ways there are to win this single race. In this example, the race lasts for 71530 milliseconds and the record distance you need to beat is 940200 millimeters. You could hold the button anywhere from 14 to 71516 milliseconds and beat the record, a total of 71503 ways!

# How many ways can you beat the record in this one much longer race?

# Your puzzle answer was 30077773.

# Both parts of this puzzle are complete! They provide two gold stars: **

BEGIN {
    true = 1; false = 0
}

{sub(/\r$/, "", $NF)} # fix Windows line endings for every line
# if we don't do this then the line "name map:\r\n" on Windows
# $NF will be "map:\r" and not match /map:$/
# and we cant fix by using /map:\r$/ because the \r isn't there on unix and Mac
# could fix by always doing /map:[\r]{0,1}$/ but we won't remember always
# and we might be matching on something that doesn't have to be last
# and its hard for new readers to pick up

/^Time:/ {
    printf "Duration:"
    f = 1
    while (++f <= NF) {
        duration = duration $f
    }
    printf(" %d\n", duration)
}

/^Distance:/ {
    printf "Record:"
    f = 1
    while (++f <= NF) {
        record = record $f
    }
    printf(" %d\n", record)
}


END {
    # in sample.txt multiply these values together, you get 288 == (4 * 8 * 9)
        # the distance traveled is the time pressed times the time left
        # so it is distance = time_pressed * (duration - time_pressed)
        # we want the integer time_pressed values that are strictly greater than the record
        # re-factor to distance = time_pressed * (duration - time_pressed) - record
        # then the integer time_pressed values that are strictly greater than 0
        # are all the integers between the roots of the quadratic equation, inclusive
        # so we need to find the roots of the quadratic equation
        # using conventional names for the quadratic equation
        # a = -1, b = duration, c = -record
        a = -1; b = duration; c = -record
        discriminant = sqrt(b * b - 4 * a * c)
        root1 = (-b + discriminant) / (2 * a)
        root2 = (-b - discriminant) / (2 * a)
        wins = int(root2-1e-9) - int(root1+1e-9)
        # Doh! that was just 2x the discriminant /2 or just the discriminant!!!
        wins2 = int(discriminant + 0.5)
        if (int(discriminant) == discriminant) {
            wins2 -= 1
        }
        # ??? that didn't work as expected
        printf "roots: (%f, %f) => %d... or %d? wins. disc=%f\n", root1, root2, wins, wins2, discriminant
    printf "\n"
    printf "Answer is %d.   or maybe %d?\n", wins, wins2 
}
