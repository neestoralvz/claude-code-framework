#!/bin/bash

echo "TDD RED PHASE: Validating Dashboard Errors"
echo "=========================================="

echo "1. Testing bash syntax error..."
bash -n /Users/nalve/.claude/system/dashboard/start_dashboard.sh
if [ $? -eq 0 ]; then
    echo "   ❌ UNEXPECTED: Bash syntax check PASSED (bug may be fixed)"
else
    echo "   ✅ EXPECTED: Bash syntax error confirmed"
fi

echo ""
echo "2. Testing Python script import..."
cd /Users/nalve/.claude/system/dashboard/scripts
python3 -c "
try:
    import dashboard_api
    handler = dashboard_api.DashboardRequestHandler(None, None, None)
    try:
        handler.log_message('GET /', '404', 'Not Found')
        print('   ❌ UNEXPECTED: Python type error NOT reproduced')
    except TypeError as e:
        if 'str' in str(e) and 'int' in str(e):
            print('   ✅ EXPECTED: Python type error confirmed')
        else:
            print('   ⚠️  Different error:', str(e))
    except Exception as e:
        print('   ⚠️  Other error:', str(e))
except ImportError as e:
    print('   ❌ IMPORT ERROR:', str(e))
"

echo ""
echo "3. Direct dashboard startup test..."
cd /Users/nalve/.claude/system/dashboard
timeout 10s ./start_dashboard.sh --help > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "   ❌ UNEXPECTED: Dashboard script ran successfully"
else
    echo "   ✅ EXPECTED: Dashboard script failed (confirming errors)"
fi

echo ""
echo "RED PHASE VALIDATION COMPLETE"
echo "Ready for GREEN PHASE: Fix the identified issues"