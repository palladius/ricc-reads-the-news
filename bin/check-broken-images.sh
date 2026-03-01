#!/bin/bash
#
# Script to check for broken image links in Jekyll posts.
#

POSTS_DIR="_posts"
ASSETS_DIR="assets"
EXIT_CODE=0

if [ ! -d "$POSTS_DIR" ]; then
    echo "Error: Directory '$POSTS_DIR' not found. Run this from the root of your Jekyll project."
    exit 1
fi

echo "Scanning for broken image links..."

# Find all image links in markdown files
# Regex captures the path from ![...](PATH)
grep -r -o -E '!\[[^]]*\]\(([^)]+)\)' "$POSTS_DIR" | while read -r line; do
    # Extract file path and post file
    POST_FILE=$(echo "$line" | cut -d: -f1)
    IMG_PATH=$(echo "$line" | sed -E 's/!\[[^]]*\]\(([^)]+)\)/\1/')

    # Skip external URLs
    if [[ "$IMG_PATH" == "http://"* || "$IMG_PATH" == "https://"* ]]; then
        continue
    fi

    # Construct the full path to the image file
    # Handles both /assets/... and assets/...
    CLEAN_IMG_PATH=$(echo "$IMG_PATH" | sed 's/^\.\///' | sed 's/^\///')
    
    if [ ! -f "$CLEAN_IMG_PATH" ]; then
        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        echo "BROKEN IMAGE in: $POST_FILE"
        echo "-> Path: $IMG_PATH"
        echo "-> Resolved to: $CLEAN_IMG_PATH (NOT FOUND)"
        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        EXIT_CODE=1
    fi
done

if [ "$EXIT_CODE" -eq 0 ]; then
    echo "✅ All good! No broken image links found."
else
    echo "🔥 Found broken images. See details above."
fi

exit "$EXIT_CODE"
