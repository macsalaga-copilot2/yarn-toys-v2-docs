#!/bin/bash

# Sanitize all exposed project IDs in docs repository
echo "Starting sanitization of exposed project IDs..."

# Replace ye3pqate with [REDACTED_PROJECT_ID] in all markdown files
find . -name "*.md" -type f -exec sed -i 's/ye3pqate/[REDACTED_PROJECT_ID]/g' {} +

echo "Sanitization complete!"

# Verify no instances remain
remaining=$(grep -r "ye3pqate" . --include="*.md" | wc -l)
if [ $remaining -eq 0 ]; then
    echo "✅ All project IDs successfully sanitized"
else
    echo "⚠️  Warning: $remaining instances still found"
    grep -rn "ye3pqate" . --include="*.md"
fi
