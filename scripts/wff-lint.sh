#!/bin/bash
# Custom WFF Best Practices Linter

echo "Running Custom WFF Linter..."
FAILED=0

# Check for hardcoded colors (should use @color or be consistent)
# Exclude black (#FF000000) and white (#FFFFFFFF) as they are common
# But we'll just warn about them.
while IFS= read -r -d '' file; do
    if grep -q "color=\"#FF[0-9A-Fa-f]\{6\}\"" "$file"; then
        echo "WARNING: Hardcoded colors found in $file. Consider using @color resources for better theme support."
    fi

    # Check for missing contentDescription on interactive or visual parts
    # This is a simplified check.
    if grep -q "<Part" "$file" && ! grep -q "contentDescription=" "$file"; then
        echo "SUGGESTION: Missing contentDescription in $file. Accessibility is important for Wear OS."
    fi
done < <(find . -name "watchface.xml" -print0)

exit $FAILED
