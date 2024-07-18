#!/bin/bash

# Fetch the top stories IDs
TOP_STORIES=$(curl -s https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty | jq -r '.[]' | head -n 10)

# Initialize an array to hold the story URLs
STORY_URLS=()

# Loop story IDs to fetch details
echo "Top Hacker News Stories:"
echo "========================"
INDEX=1
for STORY_ID in $TOP_STORIES
do
    STORY_DETAILS=$(curl -s https://hacker-news.firebaseio.com/v0/item/${STORY_ID}.json?print=pretty)
    STORY_TITLE=$(echo $STORY_DETAILS | jq -r '.title')
    STORY_URL=$(echo $STORY_DETAILS | jq -r '.url')


    if [ "$STORY_URL" != "null" ]; then
        echo -e "$INDEX. \033[1m$STORY_TITLE\033[0m"
        echo "$STORY_URL"
        echo ""
        STORY_URLS+=("$STORY_URL")
        ((INDEX++))
    fi
done

echo "Enter the number of the story you'd like to visit (0 to cancel):"
read -r SELECTION

# Validate and open link
if [[ "$SELECTION" =~ ^[0-9]+$ ]] && [ "$SELECTION" -le "${#STORY_URLS[@]}" ] && [ "$SELECTION" -gt 0 ]; then
    URL=${STORY_URLS[$((SELECTION-1))]}
    echo "Opening: $URL"
    open -a "Firefox" "$URL"
elif [ "$SELECTION" -eq 0 ]; then
    echo "Aborted."
else
    echo "Invalid selection."
fi