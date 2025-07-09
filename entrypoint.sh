#!/bin/sh

# Ensure pb_data directory exists
mkdir -p /pb/pb_data

# Check if pb_data is empty (ignoring .db files and lost+found)
VALID_FILES=$(find /pb/pb_data -mindepth 1 -not -name 'lost+found' -not -name '*.db' | wc -l)

if [ "$VALID_FILES" -eq 0 ]; then
    echo "📂 Empty or non-valid volume detected. Copying default data..."
    cp -R /pb/default_pb_data/* /pb/pb_data/
else
    echo "✅ Existing data detected. Skipping initialization."
fi

# Run PocketBase
exec /pb/pocketbase serve --http=0.0.0.0:8080