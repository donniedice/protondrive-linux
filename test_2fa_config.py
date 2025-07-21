#!/usr/bin/env python3
"""Test script for ProtonDrive 2FA configuration"""

import subprocess
import sys

def test_protondrive_config():
    print("Testing ProtonDrive configuration with 2FA support...")
    
    # Check if protondrive remote exists
    result = subprocess.run(["rclone", "listremotes"], capture_output=True, text=True)
    if "protondrive:" in result.stdout:
        print("✓ ProtonDrive remote found")
        
        # Try to list directories
        print("\nTesting connection...")
        test_result = subprocess.run(
            ["rclone", "lsd", "protondrive:"],
            capture_output=True, text=True
        )
        
        if test_result.returncode == 0:
            print("✓ Connection successful!")
            print("\nDirectories found:")
            print(test_result.stdout)
        else:
            print("✗ Connection failed:")
            print(test_result.stderr)
            
            # Check config
            print("\nCurrent configuration:")
            config_result = subprocess.run(
                ["rclone", "config", "show", "protondrive"],
                capture_output=True, text=True
            )
            # Don't print passwords
            for line in config_result.stdout.split('\n'):
                if 'pass' not in line.lower():
                    print(line)
    else:
        print("✗ ProtonDrive remote not found")
        print("Please configure it using the GUI first")

if __name__ == "__main__":
    test_protondrive_config()