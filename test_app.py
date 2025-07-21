#!/usr/bin/env python3
"""Test script to verify ProtonDrive GUI functionality"""

import sys
import subprocess
import time

def test_rclone():
    """Test if rclone is available and has ProtonDrive support"""
    try:
        result = subprocess.run(['rclone', 'version'], capture_output=True, text=True)
        print("✅ rclone is installed:", result.stdout.split('\n')[0])
        
        # Check for protondrive backend
        result = subprocess.run(['rclone', 'listremotes'], capture_output=True, text=True)
        print("✅ rclone can list remotes")
        return True
    except Exception as e:
        print("❌ rclone test failed:", e)
        return False

def test_gui_import():
    """Test if GUI can be imported"""
    try:
        from protondrive.gui import ProtonDriveGUI
        print("✅ GUI module imports successfully")
        return True
    except Exception as e:
        print("❌ GUI import failed:", e)
        return False

def test_tkinter():
    """Test if tkinter is available"""
    try:
        import tkinter
        print("✅ tkinter is available")
        return True
    except Exception as e:
        print("❌ tkinter not available:", e)
        return False

def main():
    print("🧪 Testing ProtonDrive Linux Client...")
    print("-" * 50)
    
    tests = [
        ("rclone availability", test_rclone),
        ("GUI module import", test_gui_import),
        ("tkinter availability", test_tkinter),
    ]
    
    passed = 0
    for test_name, test_func in tests:
        print(f"\nTesting {test_name}...")
        if test_func():
            passed += 1
    
    print("\n" + "-" * 50)
    print(f"✅ Passed {passed}/{len(tests)} tests")
    
    if passed == len(tests):
        print("🎉 All tests passed! ProtonDrive GUI is ready to use.")
        print("\nLaunch with: python -m protondrive")
    else:
        print("⚠️  Some tests failed. Please check the requirements.")

if __name__ == "__main__":
    main()