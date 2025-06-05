#!/bin/bash

# Get the ID of the current space
CURRENT_SPACE_ID=$(yabai -m query --spaces --space | jq -r '.id')
CURRENT_SPACE_INDEX=$(yabai -m query --spaces --space | jq -r '.index')

# Check if there are windows on the current space
NUM_WINDOWS=$(yabai -m query --windows --space "$CURRENT_SPACE_INDEX" | jq '. | length')

if [ "$NUM_WINDOWS" -gt 0 ]; then
    # Move all windows from current space to the previous space
    yabai -m query --windows --space "$CURRENT_SPACE_INDEX" | jq -r '.[].id' | while read -r wid; do
        yabai -m window "$wid" --space prev
    done
fi

# Switch to the previous space (now contains the moved windows)
yabai -m space --focus prev

# Now, try to destroy the original (now empty) space
# We use its ID to be precise
yabai -m space --destroy "$CURRENT_SPACE_INDEX" 

# Optional: Add a notification if the space couldn't be destroyed
if [ $? -ne 0 ]; then
    echo "Could not destroy space $CURRENT_SPACE_INDEX. Make sure it's empty and not the last space on the display." >&2
fi
