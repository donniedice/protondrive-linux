#!/bin/bash
# ProtonDrive Linux GUI Launcher

echo "ProtonDrive Linux Client Launcher"
echo "================================="

# Check if we're in the project directory
if [ -f "protondrive/gui.py" ]; then
    # Check for virtual environment
    if [ -d "venv" ]; then
        echo "Found virtual environment, activating..."
        source venv/bin/activate
    fi
    
    # Try to run via module first
    if python -m protondrive 2>/dev/null; then
        exit 0
    fi
    
    # Try direct script execution
    if python protondrive/gui.py 2>/dev/null; then
        exit 0
    fi
fi

# Try system-wide installation
if command -v protondrive-gui &> /dev/null; then
    echo "Running system-wide installation..."
    protondrive-gui
    exit 0
fi

echo "Error: Could not find ProtonDrive GUI installation"
echo ""
echo "To install:"
echo "  pip install protondrive-linux"
echo ""
echo "Or run from source:"
echo "  python -m protondrive"
exit 1