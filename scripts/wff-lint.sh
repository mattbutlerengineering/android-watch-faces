#!/bin/bash
# Custom WFF Best Practices Linter

echo "Running Custom WFF Linter..."
FAILED=0

# Check for Ambient Mode support
while IFS= read -r -d '' file; do
    echo "Analyzing $file for Best Practices..."
    
    # Check for hardcoded colors
    if grep -q "color=\"#FF[0-9A-Fa-f]\{6\}\"" "$file"; then
        echo "  [WARNING] Hardcoded colors found. Consider using @color resources."
    fi

    # Check for Accessibility
    if grep -q "<Part" "$file" && ! grep -q "contentDescription=" "$file"; then
        echo "  [SUGGESTION] Missing contentDescription. Accessibility is important for Wear OS."
    fi

    # Check for Ambient Mode Variants (Burn-in protection)
    if ! grep -q "mode=\"AMBIENT\"" "$file"; then
        echo "  [CRITICAL] No AMBIENT mode variants found! Your watch face might cause burn-in or drain battery."
    fi

    # Check for Second Hand in Ambient Mode
    if grep -q "<SecondHand" "$file" && ! grep -A 5 "<SecondHand" "$file" | grep -q "mode=\"AMBIENT\""; then
        echo "  [CRITICAL] Second hand detected without an AMBIENT variant. It MUST be hidden or modified in ambient mode."
    fi

    # Check for Digital Seconds in Ambient Mode
    if grep -q "format=\".*:ss.*\"" "$file" && ! grep -A 5 "format=\".*:ss.*\"" "$file" | grep -q "mode=\"AMBIENT\""; then
         echo "  [CRITICAL] Digital seconds detected without an AMBIENT variant."
    fi
done < <(find . -name "watchface.xml" -print0)

exit $FAILED
