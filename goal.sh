#!/bin/bash

# Ensure ROS environment is sourced
source /opt/ros/noetic/setup.bash

# Goal message template
goal_template='{
"header": {
  "seq": 0,
  "stamp": {
    "secs": 0,
    "nsecs": 0
  },
  "frame_id": "map"
},
"pose": {
  "position": {
    "x": %d,
    "y": 0.0,
    "z": 0.0
  },
  "orientation": {
    "x": 0.0,
    "y": 0.0,
    "z": 0.0,
    "w": 1.0
  }
}
}'

# Array of x positions
positions=(-10 5 20)

# Function to publish a goal
publish_goal() {
  local x_position=$1
  local goal_msg=$(printf "$goal_template" $x_position)
  rostopic pub -1 /move_base_simple/goal geometry_msgs/PoseStamped "$goal_msg"
}

# Loop to publish goals every 5 seconds
while true; do
  for x in "${positions[@]}"; do
    publish_goal $x
    sleep 11.5
  done
done